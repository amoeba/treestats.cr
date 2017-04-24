require "./spec_helper"

describe "TreeStats" do

  it "renders /" do
    get "/"

    response.status_code.should eq 200
    response.body.should eq "Welcome to TreeStats!"
  end

  it "can insert new characters" do
    post "/character", body: "{ server: 'test', name: 'test'}"
    

  end

end