require "./spec_helper"

describe "TreeStats" do

  # You can use get,post,put,patch,delete to call the corresponding route.
  it "renders /" do
    get "/"
    response.body.should eq "Welcome to TreeStats!"
  end

end