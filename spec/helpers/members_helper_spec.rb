# coding: UTF-8

require 'spec_helper'

describe MembersHelper do
  describe "member_donations" do
    it "should display the member's total donations" do
      helper.member_donations(50.0).should match(/£50/)
    end
    
    it "shouldn't display a zero total" do
      helper.member_donations(0).should be_nil
    end
  end
end
