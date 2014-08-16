require "spec_helper"

describe NullQuestion do
  context "#person" do
    it "is a NullPerson" do
      expect(NullQuestion.new.person).to be_a NullPerson
    end
  end
end
