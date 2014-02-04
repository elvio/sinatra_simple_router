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

  class HasAncestor < Sinatra::Base
  end

  class DoesntHaveAncestor
  end
end
