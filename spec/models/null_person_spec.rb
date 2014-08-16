require "spec_helper"

describe NullPerson do
  context "#image_url" do
    it "is blank" do
      expect(NullPerson.new.image_url).to eq ""
    end
  end

  context "#name" do
    it "is encouragement to begin" do
      expect(NullPerson.new.name).to eq "Here we go!"
    end
  end

  context "#bio" do
    it "is blank" do
      expect(NullPerson.new.bio).to eq ""
    end
  end

  context "#trivia" do
    it "is empty" do
      expect(NullPerson.new.trivia).to eq []
    end
  end
end
