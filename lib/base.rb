require 'result_set'

module Testify
  class Base
    def self.framework (fw = nil)
      class_eval do
        @@framework = Testify::Framework::find(fw) if fw
        @@framework
      end
    end

    def framework
      @@framework
    end

    def run
      @last_run = ResultSet.new
      @last_run.status = Testify::Status::Passed.new

      @last_run
    end

    def status
      @last_run.nil? ? nil : @last_run.status
    end

  end
end
