require_relative '../lib/testify'
require_relative 'awesome_test_framework'
require_relative 'dots'
require_relative 'summary'

class AwesomeRunner
  include Testify::Runner

  # Specify the framework we want to use.  This alias is defined in
  # AwesomeTestFramework.
  #
  framework :awesome

  # Specify the middleware.  Again, this is defined in RadMiddleware.
  #
  middleware :summary, :dots
end

# Instantiate the runner and run the tests.
#
tests_path = File.join(File.dirname(__FILE__), 'awesome_tests')
@runner = AwesomeRunner.new
results = @runner.run(:path => tests_path)

#puts "#{results.size} tests run"
#results.each do |res|
#  puts "#{res.status} - #{res.message}"
#end
