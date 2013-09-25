require "spec_helper"
require "sinatra_simple_router"

module SinatraSimpleRouter
  describe Controller do
    describe "method delegation" do
      let(:app) { double("App", body: "") }
      let(:controller) { ItemsController.new(app) }

      context "when the method is present in the Sinatra class" do
        it "delegates to the class" do
          expect(app).to receive(:body)
          controller.body "test"
        end

        it "exposes the instances variables" do
          controller.instance_variable_set(:"@country", "brazil")
          expect(app).to receive(:instance_variable_set).with(:"@country", "brazil")
          controller.body "test"
        end
      end

      context "when the method is not present in the Sinatra class" do
        it "raises an exception" do
          expect { controller.unknown }.to raise_error
        end
      end
    end
  end
end
