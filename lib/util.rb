Dir.foreach( File.join( File.dirname(__FILE__), 'util' ) ) do |entry|
  require "util/#{entry}" if entry =~ /\.rb/
end
