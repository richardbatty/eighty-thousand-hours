require 'spec_helper'

describe Charity do
  before :each do
    @charity = FactoryGirl.create :charity
  end
  
  it "should have a valid factory" do
    @charity.should be_valid
  end
  
  describe "name" do
    it "should exist" do
      @charity.name = ""
      @charity.should_not be_valid
    end
    
    it "should be unique" do
      @another_charity = FactoryGirl.build :charity, name: @charity.name
      @another_charity.should_not be_valid
    end
  end
  
  describe "website" do
    it "should exist" do
      @charity.website = ""
      @charity.should_not be_valid
    end
    
    it "should be unique" do
      @another_charity = FactoryGirl.build :charity, website: @charity.website
      @another_charity.should_not be_valid
    end
    
    it "should be formatted like a website" do
      @charity.website = "this isn't a url"
      @charity.should_not be_valid
    end
  end
  
end
