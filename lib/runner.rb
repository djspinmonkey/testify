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
      @status = :stub
      return
      # actual stuff follows
      env = {}
      header, footer, @status, test_results = @framework.call( env )
    end

  end
end
