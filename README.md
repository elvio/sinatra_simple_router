# SinatraSimpleRouter

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

class UsersController < SinatraSimpleRouter::Controller
    def show
        @user = User.find(params[:id])
        erb :"users/show"
    end
    
    def update
        @user = User.find(params[:id])
        @user.update_attributes(params[:user])
        redirect "/users/#{@user.id}"
    end
end

class Application < Sinatra::Base
    include SinatraSimpleRouter
    
    match :get, "/users/:id", UsersController, :show
    match :patch, "/users/:id", UsersController, :update
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
