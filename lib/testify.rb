# Make sure we're grabbing the right version of everything.
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'util'
require 'status'
require 'framework'
require 'base'

# Put the LOAD_PATH back the way it was.
$LOAD_PATH.shift
