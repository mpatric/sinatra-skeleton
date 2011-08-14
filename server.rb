Encoding.default_internal = Encoding.default_external = 'UTF-8'

require "rubygems"
require "bundler/setup"
require "sinatra"

require "erb"
require "haml"
require "sass/plugin/rack"

# Require classes needed for project
require File.join(File.dirname(__FILE__), *%w[lib foo])

use Sass::Plugin::Rack

configure do
  set :views, File.expand_path(File.join(File.dirname(__FILE__), 'views'))
  set :public, File.expand_path(File.join(File.dirname(__FILE__), 'public'))
  set :haml, { :attr_wrapper => '"', :format => :html5 }
end

configure :development do
  require 'sinatra/reloader'
  Sinatra::Application.also_reload "lib/**/*.rb"
end

helpers do
  def em(text)
    "<em>#{text}</em>"
  end
end

not_found do
  haml :not_found
end

error do
  haml :error
end

get '/' do
  @foo ||= Foo.new
  erb :index
end

get '/greetings/:name' do
  haml :greetings
end
