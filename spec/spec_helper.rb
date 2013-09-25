require "rubygems"
require "bundler/setup"
require "simple_router"
require "sinatra"

module SimpleRouter
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
    include SimpleRouter
  end

  class HasAncestor < Sinatra::Base
  end

  class DoesntHaveAncestor
  end
end
