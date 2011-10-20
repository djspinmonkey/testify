# Output a dot every time a test passes, an F when it fails, or a ! on an
# error.  On any other status, it prints a ?.
#
class Dots < Testify::Middleware::Base
  aka :dots

  def call( env )
    env[:hooks][:after_each].push(lambda do |result|
      case result.status
      when :pass
        print '.'
      when :fail
        print 'F'
      when :error
        print '!'
      else
        print '?'
      end
    end)

    env[:hooks][:after_all].push(lambda { |ignored| puts; puts })

    @app.call(env)
  end
end
