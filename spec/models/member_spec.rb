require 'spec_helper'

describe Member do
  it "should have more fleshed out tests" do
    pending
  end
  
  describe "pledge" do
    it "should accept pledging users" do
      member = FactoryGirl.build :member, pledge: '1'
      member.should be_valid
    end
    
    it "should reject non-pledging users" do
      member = FactoryGirl.build :member, pledge: '0'
      member.should_not be_valid
    end
    
  end
end