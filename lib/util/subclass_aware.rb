require 'set'

module Testify
  module SubclassAware

    def self.extended (klass) #nodoc;
      klass.class_exec { class_variable_set(:@@subclasses, Set.new) }
    end

    # TODO: Find a way for self.inherited on the extended class not to blow
    # this away without requiring a bunch of alias chain hoops to be jumped
    # through.
    def inherited(sub) #nodoc;
      class_exec { class_variable_get(:@@subclasses).add sub }
    end

    ##
    # Return an array of all known subclasses (and sub-subclasses, etc) of this
    # class.
    #
    def subclasses
      class_exec { class_variable_get(:@@subclasses).to_a }
    end

    ##
    # Clear all info about known subclasses.  Usefull for testing, but it is
    # unlikely you would use it for much else.
    #
    def forget_subclasses
      class_exec { class_variable_get(:@@subclasses).clear }
    end

  end
end
