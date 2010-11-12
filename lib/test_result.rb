module Testify

  # A TestResult object represents the results of running a single test,
  # whatever that means in the context of your framework.
  #
  class TestResult
    attr_accessor :status, :message, :file, :line

    def initialize (options = {})
      @status   = options[:status]
      @message  = options[:message]
      @file     = options[:file]
      @line     = options[:line]
    end

  end

end
