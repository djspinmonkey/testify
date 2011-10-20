module Testify
  module Middleware
    class Base
      extend Aliasable

      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env)
      end
    end
  end
end
