# SinatraSimpleRouter

[![Build Status](https://travis-ci.org/elvio/sinatra_simple_router.png)](https://travis-ci.org/elvio/sinatra_simple_router)
[![RubyGem](https://badge.fury.io/rb/sinatra_simple_router.png)](https://rubygems.org/gems/sinatra_simple_router)

Simple routing abstraction for Sinatra applications.

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra_simple_router'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra_simple_router

## Usage

```ruby
require "sinatra"
require "sinatra_simple_router"

class OrdersController
    def initialize(app)
        @app = app
    end

    def show
        @order = Order.find(params[:id])
        @app.content_type "application/json"
        @app.body @order.to_json
    end
end

class Application < Sinatra::Base
    include SinatraSimpleRouter
    match :get, "/orders/:id.json", OrdersController, :show
end
```

### SinatraSimpleRouter::Controller

```ruby
class ItemsController < SinatraSimpleRouter::Controller
    def show
      @item = Item.find(params[:id])
      render json: @item
    end
end

class Application < Sinatra::Base
    include SinatraSimpleRouter
    match :get, "/items/:id.json", ItemsController, :show
end
```

### Versioning URLs

```ruby
require "sinatra"
require "sinatra_simple_router"

class V1::ItemsController < SinatraSimpleRouter::Controller
    def show
      @item = Item.find(params[:id])
      render json: @item
    end
end

class V2::ItemsController < SinatraSimpleRouter::Controller
    def show
      @item = Item.find(params[:id])
      render json: ItemDecorator.new(@item).to_json
    end
end

class Application < Sinatra::Base
    include SinatraSimpleRouter

    # maps '/v1/items/:id.json' to V1::ItemsController
    version :v1 do
      match :get, "/items/:id.json", V1::ItemsController, :show
    end

    # maps '/v2/items/:id.json' to V2::ItemsController
    version :v2 do
      match :get, "/items/:id.json", V2::ItemsController, :show
    end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
