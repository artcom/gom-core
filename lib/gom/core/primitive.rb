class Gom::Core::Primitive

  TypeMap = {
    Symbol	  => :symbol,
    Fixnum	  => :integer,
    Bignum	  => :integer,
    #BigDecimal	  => :decimal,
    Float	  => :float,
    Date	  => :date,
    DateTime	  => :datetime,
    Time	  => :datetime,
    TrueClass	  => :boolean,
    FalseClass	  => :boolean,
    URI::HTTP     => :uri,
    URI::HTTPS    => :uri,
    URI::Generic  => :uri,
    String        => :txt,
  }

  TypeCodes = TypeMap.values.uniq.sort

  Parsers = {
    :date     => Proc.new { |date| ::Date.parse(date) },
    :datetime => Proc.new { |time| ::DateTime.parse(time) },
    :float    => Proc.new { |txt| txt.to_f },
    :integer  => Proc.new { |txt| txt.to_i },
    :uri      => Proc.new { |s| URI.parse(s) },
    :boolean  => Proc.new { |s| (s == 'true' ? true : false) },
  }

  Formatters = Hash.new(Proc.new{|o|o.to_s}).update(
    :txt      => Proc.new { |s| s.to_s },
    :date     => Proc.new { |date| date.strftime('%Y-%m-%d') }, #.to_s(:db) },
    :datetime => Proc.new { |time|
      # back and forth, trying to 'normalize' the myriad of time formats
      DateTime.parse(time.to_s).strftime
      #DateTime.parse(time.to_s).xmlschema
      #time.xmlschema
    }
  )

  # text, type -> value
  def self.decode txt, type = :txt
    parser = type && Parsers[type.to_sym]
    parser ? parser.call(txt) : txt
  end

  # value -> text, type
  def self.encode value
    type = TypeMap[value.class] || :txt
    formatter = Formatters[type]
    [ formatter.call(value), type]
  end
end
