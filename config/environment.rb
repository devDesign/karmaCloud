require 'rubygems'
require 'bundler/setup'
require 'slim'

require 'active_support/all'

# Load Sinatra Framework (with AR)
require 'sinatra'
require 'sinatra/activerecord'
require "sinatra/json"
require 'action_view'
require 'geocoder'
require "geocoder/railtie"
Geocoder::Railtie.insert
require 'faker'
require 'factory_girl'
require 'gon-sinatra'
require 'pg'
require 'pry' if development?
require 'digest/sha1'
require 'random-location'




APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

# Sinatra configuration
configure do
  set :root, APP_ROOT.to_path
  set :server, :puma

  enable :sessions
  set :session_secret, ENV['SESSION_KEY'] || 'lighthouselabssecret'

  set :views, File.join(Sinatra::Application.root, "app", "views")

end
include ActionView::Helpers::DateHelper
# Gon configuration
Sinatra::register Gon::Sinatra

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Load the routes / actions
require APP_ROOT.join('app', 'actions')
