require "spec_helper"
require "sinatra_simple_router"

module SinatraSimpleRouter
  describe Controller do
    let(:app) { double("App", body: "") }
    let(:controller) { ItemsController.new(app) }

    describe "#render" do
      let(:content) { double("Content") }
      let(:json) { double("JSON") }

      it "renders json" do
        expect(app).to receive(:content_type).with("application/json")
        expect(app).to receive(:body).with(json)
        expect(content).to receive(:to_json).and_return(json)

        controller.render json: content
      end

      it "renders html" do
        expect(app).to receive(:content_type).with("text/html")
        expect(app).to receive(:body).with(content)
        expect(content).to receive(:to_s).and_return(content)

        controller.render html: content
      end

      it "sets the status" do
        app.stub(:content_type)
        expect(app).to receive(:status).with(201)
        controller.render html: "", status: 201
      end
    end

    describe "method delegation" do
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
