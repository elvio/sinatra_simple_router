require "spec_helper"
require "simple_router"

module SimpleRouter
  describe SimpleRouter do
    describe ".included" do
      context "in a Sinatra::Base ancestors" do
        it "includes the method" do
          expect { HasAncestor.send(:include, SimpleRouter) }.to_not raise_error
        end
      end

      context "in a non Sinatra::Base ancestors" do
        it "raises an exception" do
          expect { DoesntHaveAncestor.send(:include, SimpleRouter) }.to raise_error
        end
      end
    end

    describe ".match" do
      before do
        MyApplication.match(:get, "/", UsersController, :index)
      end

      it "dispatches the route to the controller class and action" do
        request = Rack::MockRequest.new(MyApplication)
        response = request.get("/")
        expect(response.body).to eq("it works")
      end
    end
  end
end
