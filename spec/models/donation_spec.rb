require 'spec_helper'

describe Donation do
  before :each do
    @donation = FactoryGirl.create :donation
  end
  
  it "has a valid factory" do
    @donation.should be_valid
  end
  
  it "belongs to a member" do
    @donation.member = nil
    @donation.should_not be_valid
  end
  
  it "belongs to a charity" do
    @donation.charity = nil
    @donation.should_not be_valid
  end
  
  it "has an amount" do
    @donation.amount = nil
    @donation.should be_invalid
  end
  
  it "is greater than fuck all" do
    @donation.amount = 0
    @donation.should be_invalid
  end
end
