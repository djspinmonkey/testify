require 'status/base'
Dir.foreach( File.join( File.dirname(__FILE__), 'status' ) ) do |entry|
  require "status/#{entry}" if entry =~ /\.rb$/
end
