require 'spec_helper'

describe Cause do
  before :each do
    @cause = FactoryGirl.create :cause
  end
  
  it "should have a valid factory" do
    @cause.should be_valid
  end
  
  describe "name" do
    it "should exist" do
      @cause.name = ""
      @cause.should_not be_valid
    end
    
    it "should be unique" do
      @another_cause = FactoryGirl.build :cause, name: @cause.name
      @another_cause.should_not be_valid
    end
  end
  
  describe "website" do
    it "should exist" do
      @cause.website = ""
      @cause.should_not be_valid
    end
    
    it "should be unique" do
      @another_cause = FactoryGirl.build :cause, website: @cause.website
      @another_cause.should_not be_valid
    end
    
    it "should be formatted like a website" do
      @cause.website = "this isn't a url"
      @cause.should_not be_valid
    end
  end
  
end
