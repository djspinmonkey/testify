require 'result_set'

module Testify
  class Base
    def self.framework (fw)
    end

    def run
      return ResultSet.new
    end

  end
end
