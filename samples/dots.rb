# Output a dot every time a test passes, an F when it fails, or a E on an
# error.  On any other status, it prints a ?.
#
class Dots 
  include Testify::Middleware

  aka :dots

  def call( env )
    # Output dots (et al) as each test runs.
    #
    env[:hooks][:after_each].push(lambda do |result|
      case result.status
      when :pass
        print '.'
      when :fail
        print 'F'
      when :error
        print 'E'
      else
        print '?'
      end
    end)

    # Output a couple newlines at the end after all the tests have run.
    #
    env[:hooks][:after_all].push(lambda { |ignored| puts; puts })

    # @app is defined by the default initializer for Middleware
    #
    @app.call(env)
  end
end
