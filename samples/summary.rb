# Output a summary of the test results after they've all been run.
#
class Summary 
  include Testify::Middleware

  aka :summary

  def call( env )
    results = @app.call(env)

    summary = Hash.new(0)
    results.each { |res| summary[res.status] += 1 }

    puts "Ran #{results.size} tests in all"
    summary.each { |status, count| puts "#{count} tests with status #{status}" }

    results
  end
end
