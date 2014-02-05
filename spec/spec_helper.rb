require "rubygems"
require "bundler/setup"
require "sinatra_simple_router"
require "sinatra"

module SinatraSimpleRouter
  class UsersController
    def initialize(app)
      @app = app
    end

    def index
      "index"
    end

    def subscribe
      "subscribe"
    end

    def raise_argument_error
      raise ArgumentError.new
    end

    def raise_runtime_error
      raise RuntimeError.new
    end
  end

  class ItemsController < Controller
  end

  class SimpleApplication < Sinatra::Base
    include SinatraSimpleRouter
    match(:get, "/", UsersController, :index)
  end

  class VersionedApplication < Sinatra::Base
    include SinatraSimpleRouter

    version :v1 do
      match(:post, "/subscribe", UsersController, :subscribe)
    end
  end

  class RescuedApplication < Sinatra::Base
    include SinatraSimpleRouter

    def handle_exception(e, c)
    end

    rescue_exception ArgumentError do |exception, controller|
      handle_exception(exception, controller)
    end

    match(:post, "/subscribe", UsersController, :raise_argument_error)
  end

  class HasAncestor < Sinatra::Base
  end

  class DoesntHaveAncestor
  end
end
