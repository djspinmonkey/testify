module Testify
  class Runner
    attr_accessor :status

    def self.framework (fw = nil)
      class_eval do
        @@framework = Testify::Framework::Base.find(fw) if fw
        @@framework
      end
    end

    def framework
      @@framework
    end

    def run
      @status = Testify::Status::Passed.new("This is just a stub.")
    end

  end
end
