#coding: UTF-8
require "spec_helper"

describe DonationMailer do
  describe "confirmation" do
    let(:donation) { FactoryGirl.create :donation }
    let(:member) { donation.member }
    let(:cause) { donation.cause }
    let(:mail) { DonationMailer.confirmation(donation) }
    
    it "is from 80000hours.org" do
      mail.from.should eq(["admin@80000hours.org"])
    end
    
    it "is to the member" do
      mail.to.should eq([member.email])
    end

    it "is titled 'Donation Confirmed'" do
      mail.subject.should eq("Donation Confirmed")
    end
    
    it "displays the member's first name" do
      mail.body.encoded.should match(member.first_name)
    end
    
    it "displays the donation amount" do
      mail.body.encoded.should match(/£\d+\.\d{2}/)
    end
    
    it "displays the cause" do
      mail.body.encoded.should match(cause.name)
    end
    
  end

end
