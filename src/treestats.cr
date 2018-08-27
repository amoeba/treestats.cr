require "kemal"
require "mongo"
require "./models/character"

client = Mongo::Client.new "mongodb://127.0.0.1:27017/treestats-dev"
db = client["treestats-dev"]
characters = db["characters"]

r = Random.new

# vals = (1..10).map { |i| (r.rand(57) + 65).unsafe_chr }
module Treestats
  # TODO Put your code here
end

post "/character" do |env|
  response = nil

  begin
    character = Character.from_json env.request.body.not_nil!
    response = character.to_json
  rescue
    response = "Exception (not implemented)"
  end

  response
end

get "/" do
  render "src/views/index.ecr", "src/views/layout.ecr"
end

get "/characters" do
  chars = characters.find({} of String => String)

  render "src/views/characters.ecr", "src/views/layout.ecr"
end

get "/servers" do
  pipeline = [{
    "$group" => {
      "_id" => "$server",
      "nchars" => { "$sum" => 1 }
    }
  }]

  servers = characters.aggregate(pipeline)

  render "src/views/servers.ecr", "src/views/layout.ecr"
end

get "/:server" do |env|
  server = env.params.url["server"]

  render "src/views/server.ecr", "src/views/layout.ecr"
end

get "/:server/:name" do |env|
  char = characters.find({
    "server" => env.params.url["server"],
    "name" => env.params.url["name"]
  }).first

  render "src/views/character.ecr", "src/views/layout.ecr"
end

Kemal.run
