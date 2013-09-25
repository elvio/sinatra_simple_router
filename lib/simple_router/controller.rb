module SimpleRouter
  class Controller
    def initialize(app)
      @app = app
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
