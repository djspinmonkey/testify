require_relative '../lib/testify'
require_relative 'awesome_test_framework'
require_relative 'dots'
require_relative 'summary'

class AwesomeRunner < Testify::Runner::Base
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
@runner = AwesomeRunner.new
results = @runner.run(:path => ARGV[0])
