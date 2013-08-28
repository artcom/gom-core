guard :rspec, :cli => '--format nested --debug --color' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/unit/#{m[1]}_spec.rb" }

  watch('spec/spec_helper.rb')  { "spec" }
  watch('lib/gom/core.rb')  { "spec" }
  watch('*.gemspec')  { "spec" }
  watch('Gemfile')  { "spec" }
end
