module Testify
  module Framework
    # A Testify framework that acts as a wrapper around stock RSpec
    class RSpecAdaptor < Testify::Framework::Base
      aka :rspec, :spec
    end
  end
end

