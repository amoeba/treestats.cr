require "./spec_helper"

describe Character do
  describe "#from_json" do
    it "can create from JSON" do
      character = Character.from_json(%({"server": "Test", "name": "Test"}))
      character.server.should eq "Test"
      character.name.should eq "Test"
    end

    it "fails on missing values" do
      expect_raises JSON::MappingError do
        Character.from_json(%({"server": "Test"}))
      end

      expect_raises JSON::MappingError do
        Character.from_json(%({"name": "Test"}))
      end
    end
  end
end
