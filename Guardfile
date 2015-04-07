# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' }, :bundler => false do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/routes.rb')
  watch(%r{^config/locales/.+\.yml$})
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
  watch(%r{^spec/support/.+\.rb$})
end

guard 'rspec', :version => 2, :cli => "--drb", :all_on_start => false, :all_after_pass => false, :bundler => false do
  watch(%r{^spec/.+_spec\.rb$})
  #watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/modules/(.+)/app/models/(.+)\.rb$})     { |m| "spec/lib/modules/#{m[1]}/models/#{m[2]}_spec.rb" }
  watch(%r{^lib/modules/(.+)/app/controllers/(.+)_(controller)\.rb$})  { |m| [
    "spec/lib/modules/#{m[1]}/routing/#{m[2]}_routing_spec.rb",
    "spec/lib/modules/#{m[1]}/#{m[3]}s/#{m[2]}_#{m[3]}_spec.rb",
    "spec/lib/modules/#{m[1]}acceptance/#{m[2]}_spec.rb",
    "spec/lib/modules/#{m[1]}requests/#{m[2]}_spec.rb"]
  }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  #watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/factories/(.+)\.rb$})                  { "spec" }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
  watch('script/service_monitor.rb')                  { "script/service_monitor" }
end
