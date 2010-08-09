module Testify
  class Runner
    extend Templatable

    attr_accessor :status, :middleware
    templatable_attr :framework

    class << self; attr_accessor :framework_class; end

    def self.framework (fw = nil)
      self.framework = Testify::Framework::Base.find(fw) if fw
      self.send(:class_variable_get, :@@framework)
    end

    def run
      @framework_instance ||= @framework.new
      env = {}
      header, footer, @status, test_results = @framework_instance.call( env )
    end

  end
end
