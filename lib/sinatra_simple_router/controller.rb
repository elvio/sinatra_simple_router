module SinatraSimpleRouter
  class Controller
    def initialize(app)
      @app = app
    end

    def render(attrs = {})
      code = attrs[:status].to_i
      status(code) if code > 0

      if attrs[:html]
        content_type "text/html"
        body attrs[:html].to_s
      elsif attrs[:json]
        content_type "application/json"
        body attrs[:json].to_json
      else
        raise ArgumentError.new("Unknown format in #{attrs.inspect}")
      end
    end

    def method_missing(method, *args, &block)
      if @app.respond_to?(method)
        (self.instance_variables - [:"@app"]).each do |v|
          @app.instance_variable_set(v, self.instance_variable_get(v))
        end
        @app.send(method, *args, &block)
      else
        super
      end
    end
  end
end
