module Testify
  module Framework

    # A sample Testify framework intended to be used while testing Testify.  A
    # "test" consists of a line in the file, which should contain the status
    # and optionally a colon and a message.
    #
    # Example test file:
    #   fail:The thing is not in the place.
    #   success
    #   pending:Need to implement cat napkins.
    #   success
    #
    class SampleFramework < Testify::Framework::Base
      aka :sample

      # Run some tests.
      def call (env)
        header = "Test Header"
        footer = "Test Footer"
        results = []

        files(env).each do |file|
          line_number = 0
          File.open(file).each_line do |line|
            line_number += 1
            (status, message) = line.split(':')
            results.push TestResult.new(:status => status.to_sym, :message => message, :file => file, :line => line_number)
          end
        end

        [header, footer, results]
      end

    end

  end
end

