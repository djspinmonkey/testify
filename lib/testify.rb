# gems
require 'classy'

# Make sure we're grabbing the right version of everything.
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'framework'
require 'runner'

# Put the LOAD_PATH back the way it was.
$LOAD_PATH.shift

# The Testify module provides some general-purpose functions that aren't
# specific to any single component.
module Testify

  # Returns the current version as an array.  (Eg, version 1.2.3 would be
  # returned as [1, 2, 3].)
  #
  def self.version
    File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).chomp.split('.').collect { |n| n.to_i }
  end

end
