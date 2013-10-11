require 'spec_helper'

include Gom::Core

describe Gom::Core::Primitive do
  it "encode/decode should fail on non supported types" do
    # TODO: test & implementation
  end

  it 'implements these known types' do
    expect(Primitive::TypeMap).to be_kind_of(Hash)
  end

  it 'lists all unique types in the TypeCode constant' do
    expect(Primitive::TypeCodes).to eq([
      :boolean, :date, :datetime, :float, :integer, :symbol, :uri
    ])

    expect(Primitive::TypeCodes).to eq(Primitive::TypeMap.values.uniq.sort)
  end

  it "encodes booleans" do
    expect(Primitive.encode(true)).to eq(['true', :boolean])
    expect(Primitive.decode(*Primitive.encode(true))).to be(true)

    expect(Primitive.encode(false)).to eq(['false', :boolean])
    expect(Primitive.decode(*Primitive.encode(false))).to be(false)
  end

  it "should encode URIs" do
    uri = URI.parse "http://www.artcom.de/"
    Primitive.encode(uri).should == [uri.to_s, :uri]
    uri.should == Primitive.decode(*Primitive.encode(uri))
  end

  it "should encode intergers" do
    val = rand 1000
    val.should == Primitive.decode(*Primitive.encode(val))
  end

  it "should encode floats" do 
    v_in = rand
    v_out, t = Primitive.encode(v_in)
    v_in.to_s.should == v_out.to_s
    :float.should == t
  end

  it "should encode datetime" do 
    t1 = DateTime.now
    t2 = Primitive.decode(*Primitive.encode(t1))
    t2.should_not == nil
    # compare times as formatted strings cause otherwise lots of weired
    # timezone & time stuff hits us with equal values beeing not considered
    # equal...
    t1.strftime.should == t2.strftime

    # TODO: to_s with :db seems to be an rails extension...
    #t1.to_s(:db).should == t2.to_s(:db)
  end

  it "should encode dates" do
    val = Date.today
    val.should == Primitive.decode(*Primitive.encode(val))
  end

  it "should encode strings" do
    s = "random text string: #{rand}."
    s.should == Primitive.decode(*Primitive.encode(s))
    [s, :string].should == Primitive.encode(s)
  end
end
