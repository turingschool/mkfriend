require "spec_helper"

describe NullPerson do
  context "#present?" do
    it "is false" do
      expect(NullPerson.new.present?).to eq false
    end
  end
end
