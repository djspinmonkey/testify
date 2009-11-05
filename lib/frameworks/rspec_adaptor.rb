module Testify
  module Frameworks
    # A Testify framework that acts as a wrapper around stock RSpec
    class RSpecAdaptor < Testify::Frameworks::Base
      aka :rspec, :spec
    end
  end
end

