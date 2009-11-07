module Testify
  module Status
    class Base
      extend Aliasable
      attr_accessor :test, :message

      def initialize (test = nil, message = '')
        @test = test
        @message = message
      end

    end
  end
end
