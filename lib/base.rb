require 'result_set'

module Testify
  class Base
    def self.framework (fw)
      class_eval do
        @@framework = Testify::Frameworks::find(fw)
      end
    end

    def framework
      @@framework
    end

    def run
      return ResultSet.new
    end

  end
end
