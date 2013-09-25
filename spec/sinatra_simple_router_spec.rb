require "spec_helper"
require "sinatra_simple_router"

module SinatraSimpleRouter
  describe SinatraSimpleRouter do
    describe ".included" do
      context "in a Sinatra::Base ancestors" do
        it "includes the method" do
          expect { HasAncestor.send(:include, SinatraSimpleRouter) }.to_not raise_error
        end
      end

      context "in a non Sinatra::Base ancestors" do
        it "raises an exception" do
          expect { DoesntHaveAncestor.send(:include, SinatraSimpleRouter) }.to raise_error
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
