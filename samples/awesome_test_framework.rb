# A sample test framework built using Testify.
#
class AwesomeTestFramework
  include Testify::Framework

  # Specify an alias for this framework.
  #
  aka :awesome

  # These are the statuses this framework might return, in increasing order of severity.
  #
  statuses :pass, :fail, :error

  # This is what a test file for this framework looks like.
  #
  file_pattern '*.aws'

  # This is where you do your thing.  In a real test framework, you'd probably
  # be testing assertions and setting up contexts and generally making the
  # magic happen here (or at least calling the libraries where the magic
  # happens).  
  #
  # In this example, we're just reading test results out of a file and calling
  # the appropriate hooks.
  #
  def call( env )
    results = []

    run_before_all_hooks(env)

    files(env).each do |file|
      open file do |f|
        f.lines.each_with_index do |line, line_number|
          run_before_each_hooks(env)

          message, status = * line.split(':')
          status = status.strip.to_sym
          result = Testify::TestResult.new( :file => file, :line => line_number, :message => message, :status => status )
          results << result

          run_after_each_hooks(env, result)
        end
      end
    end

    run_after_all_hooks(env, results)

    results
  end

end
