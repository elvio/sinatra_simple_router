module SinatraSimpleRouter
  autoload :Version, "sinatra_simple_router/version"
  autoload :Controller, "sinatra_simple_router/controller"

  def self.included(base)
    if base.ancestors.include?(Sinatra::Base)
      base.extend(ClassMethods)
    else
      raise "SinatraSimpleRouter needs to be included in a Sinatra::Base decendent"
    end
  end

  module ClassMethods
    @@rescued_exceptions = {}

    def rescue_exception(exception, &block)
      exception_name = exception.name

      if @@rescued_exceptions[exception_name]
        @@rescued_exceptions[exception_name] << block
      else
        @@rescued_exceptions[exception_name] = [block]
      end
    end

    def match(method, path, klass, action)
      if @version
        path = "/#{@version}#{path}"
      end

      send(method, path) do
        begin
          klass.new(self).send(action)
        rescue => e
          handlers = Array(@@rescued_exceptions[e.class.name])
          if handlers.any?
            handlers.map do |handler|
              handler.call(e, klass.new(self))
            end
          else
            raise e
          end
        end
      end
    end

    def version(version, &block)
      @version = version
      instance_eval(&block)
      @version = nil
    end
  end
end
