# Output a summary of the test results after they've all been run.
#
class Summary < Testify::Middleware::Base
  aka :summary

  def call( env )
    results = @app.call(env)

    summary = Hash.new(0)
    results.each { |res| summary[res.status] += 1 }

    summary.each { |status, count| puts "#{count} tests with status #{status}" }

    results
  end
end
