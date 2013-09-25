module SimpleRouter
  autoload :Version, "simple_router/version"
  autoload :Controller, "simple_router/controller"

  def self.included(base)
    if base.ancestors.include?(Sinatra::Base)
      base.extend(ClassMethods)
    else
      raise "SimpleRouter needs to be included in a Sinatra::Base decendent"
    end
  end

  module ClassMethods
    def match(method, path, klass, action)
      send(method, path) do
        klass.new(self).send(action)
      end
    end
  end
end
