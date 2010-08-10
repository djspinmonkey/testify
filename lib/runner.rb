module Testify
  class Runner
    extend Templatable

    attr_accessor :status, :framework_instance, :test_results
    templatable_attr :framework

    class << self; attr_accessor :framework_class; end

    def self.framework (fw = nil)
      self.framework = Testify::Framework::Base.find(fw) if fw
      self.send(:class_variable_get, :@@framework)
    end

    def run ( options = {} )
      @framework_instance ||= framework.new
      env = Testify.env_defaults.merge options
      header, footer, @status, @test_results = @framework_instance.call( env )
    end

  end
end
