# gems
require 'classy'

# Make sure we're grabbing the right version of everything.
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'framework'
require 'runner'
require 'middleware'
require 'test_result'

# Put the LOAD_PATH back the way it was.
$LOAD_PATH.shift

# The Testify module provides some general-purpose functions that aren't
# specific to any single component.
module Testify

  # Provides some reasonable defaults to create a new env hash.  This method
  # does not fill in :path or :files, so you'll need to explicitly specify one
  # or the other.
  #
  def self.env_defaults
    { :testify_errors => STDERR,
      :testify_output => STDOUT,
      :testify_version => Testify.version,
      :testify_hooks => { :before_all => [], 
                          :after_all => [], 
                          :before_each => [], 
                          :after_each => [], 
                          :after_status => Hash.new { |hash, status| hash[status] = [] } 
                        }
    }
  end

  # Returns the current version as an array.  (Eg, version 1.2.3 would be
  # returned as [1, 2, 3].)
  #
  def self.version
    File.read(File.join(File.dirname(__FILE__), '..', 'VERSION')).chomp.split('.').collect { |n| n.to_i }
  end

end
