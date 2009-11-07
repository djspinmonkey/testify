require 'framework/base'
Dir.foreach( File.join( File.dirname(__FILE__), 'framework' ) ) do |entry|
  require "framework/#{entry}" if entry =~ /\.rb$/
end
