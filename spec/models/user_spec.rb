require 'spec_helper'

describe User do
  
  it "should create a new instance given a valid attribute" do
    FactoryGirl.create :user
  end
  
  it "should require an email address" do
    no_email_user = FactoryGirl.build :user, email: ""
    no_email_user.should_not be_valid
  end
  
  # it "should reject duplicate email addresses" do
  #   user = FactoryGirl.create :user
  #   user_with_duplicate_email = FactoryGirl.build :user, email: user.email
  #   user_with_duplicate_email.should_not be_valid
  # end
  # 
  it "should reject email addresses identical up to case" do
    user = FactoryGirl.create :user
    # can't use FactoryGirl.build, as it still inserts the record in the db
    # perhaps because of friendly_id?
    user_with_duplicate_email = User.new(
      FactoryGirl.attributes_for(:user, email: user.email.upcase) )
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "name" do
    it "should be required" do
      no_name_user = FactoryGirl.build :user, name: ""
      no_name_user.should_not be_valid
    end
  end
  
  describe "passwords" do

    before(:each) do
      @user = FactoryGirl.create :user
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password validations" do

    it "should require a password" do
      FactoryGirl.build(:user, password: "", password_confirmation: "").
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      FactoryGirl.build(:user, password_confirmation: "invalid").
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      FactoryGirl.build(:user, password: short, password_confirmation: short).
        should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = FactoryGirl.create :user
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end
  
end
