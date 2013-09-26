module SinatraSimpleRouter
  class Controller
    def initialize(app)
      @app = app
    end

    def render(options = {})
      if code=options[:status].to_i and code > 0
        status code
      end

      if html=options[:html]
        content_type "text/html"
        body html.to_s
      elsif json=options[:json]
        content_type "application/json"
        body json.to_json
      else
        raise ArgumentError.new("Unknown format in #{options.keys.sort}")
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
