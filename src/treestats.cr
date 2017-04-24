# require "./treestats/*"
require "kemal"
require "mongo"
require "redis"

redis = Redis.new

client = Mongo::Client.new "mongodb://127.0.0.1:27017/test"
db = client["test"]

populations = db["populations"]
characters = db["characters"]

# module Treestats
#   # TODO Put your code here
# end

post "/character" do |env|
  characters.insert({ "server" => "test2", "name" => "test"})
end

post "/population" do |env|
  populations.insert({ "server" => "test2", "count" => 100})
end

get "/" do
  render "src/views/index.ecr"
end

get "/characters" do
  chars = characters.find({} of String => String)
  render "src/views/characters.ecr"
end

get "/character/:server/:character" do |env|
  server = env.params.url["server"]
  character = env.params.url["character"]

  render "src/views/character.ecr"
end

get "/servers" do
  pipeline = [ { "$group" => { "_id" => "$server", "nchars" => { "$sum" => 1 }} } ]
  servs = characters.aggregate(pipeline)
  render "src/views/servers.ecr"
end

get "/server/:server" do |env|
  server = env.params.url["server"]

  render "src/views/server.ecr"
end

get "/populations" do
  pops = populations.find({} of String => Int32)

  render "src/views/populations.ecr"
end

Kemal.run