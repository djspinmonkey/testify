require 'middleware/base'
Dir.foreach( File.join( File.dirname(__FILE__), 'middleware' ) ) do |entry|
  require "middleware/#{entry}" if entry =~ /\.rb$/
end
