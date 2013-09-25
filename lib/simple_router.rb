require "simple_router/version"

module SimpleRouter
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
