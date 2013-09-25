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
      "it works"
    end
  end

  class ItemsController < Controller
  end

  class MyApplication < Sinatra::Base
    include SinatraSimpleRouter
  end

  class HasAncestor < Sinatra::Base
  end

  class DoesntHaveAncestor
  end
end
