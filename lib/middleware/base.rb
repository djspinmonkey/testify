module Testify
  module Middleware
    class Base
      extend Aliasable

      # By default, Testify middleware is initialized with only the next app on
      # the stack.  If you override this, you may also need to override
      # Runner::Base.construct_app_stack (if you are using that class).
      #
      def initialize(app)
        @app = app
      end

      # By default, the middleware base class just calls the next app on the
      # stack - you will almost certainly want to override this method.
      #
      def call(env)
        @app.call(env)
      end

    end
  end
end
