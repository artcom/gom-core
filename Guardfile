# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, :cli => '--format nested --debug --color' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }

  watch('spec/spec_helper.rb')  { "spec" }
  watch('lib/gom/core.rb')  { "spec" }
  watch('*.gemspec')  { "spec" }
  watch('Gemfile')  { "spec" }
end
