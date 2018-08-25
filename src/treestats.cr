require "kemal"
require "mongo"

client = Mongo::Client.new "mongodb://127.0.0.1:27017/test"
db = client["treestats-test"]

characters = db["characters"]

module Treestats
  # TODO Put your code here
end

post "/character" do |env|
  # TODO: Implement create/update feature
  characters.insert({ "server" => "Test", "name" => "Test"})
end


get "/" do
  render "src/views/index.ecr"
end

get "/characters" do
  chars = characters.find({} of String => String)

  render "src/views/characters.ecr"
end

get "/character/:server/:name" do |env|
  character = characters.find({
    "server" => env.params.url["server"],
    "name" => env.params.url["name"]
  })

  render "src/views/character.ecr"
end

get "/servers" do
  pipeline = [{
    "$group" => { 
      "_id" => "$server", 
      "nchars" => { "$sum" => 1 }
    }
  }]

  servers = characters.aggregate(pipeline)

  render "src/views/servers.ecr"
end

get "/server/:server" do |env|
  server = env.params.url["server"]

  render "src/views/server.ecr"
end

Kemal.run
