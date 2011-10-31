module Testify
  module Middleware
    include Aliasable

    # By default, Testify middleware is initialized with only the next app on
    # the stack.  If you override this in a way that changes the signature, you
    # may also need to override Runner.construct_app_stack.
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
