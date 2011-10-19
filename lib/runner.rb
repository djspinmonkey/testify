require 'runner/base'
Dir.foreach( File.join( File.dirname(__FILE__), 'runner' ) ) do |entry|
  require "runner/#{entry}" if entry =~ /\.rb$/
end
