require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    subject { described_class.new(name: "Bruno Mars", email: "test@test.com", password: "azerty", password_confirmation: "azerty") }
    user = described_class.new(name: "test", email: "test@test.com", password: "12345", password_confirmation: "12345")

    it "is valid with the valid attributes" do
      expect(subject).to be_valid
    end 

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).not_to be_valid
    end 

    it "is not valid without a password confirmation" do
      subject.password_confirmation = nil
      expect(subject).not_to be_valid
    end

    it "is not valid if the password and password_confirmation are not the same" do
      subject.password_confirmation = "pw1234"
      expect(subject).not_to be_valid
    end

    it "must be at least 5 characters long" do
      subject.password = "abc"
      expect(subject).not_to be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).not_to be_valid
    end

    it "must have a unique email and not be case sensititve" do
      subject.save
      expect(user).not_to be_valid
    end

    it "must have a unique email and not be case sensitive" do 
      subject.save
      user.email = "TEST@TEST.com"
      expect(user).not_to be_valid
    end
  end

  describe ".authenticate_with_credentials" do
    subject { described_class.new(name: "Bruno Mars", email: "test@test.com", password: "azerty", password_confirmation: "azerty") }

    it "is still able to authenticate with whitespaces in the email" do
      subject.save
      expect(User.authenticate_with_credentials(" test@test.com ", "azerty")).not_to be_nil
    end

    it "is still able to authenticate even with wrong cases in the email" do
      subject.save
      expect(User.authenticate_with_credentials("TeSt@TEST.cOm", "azerty")).not_to be_nil
    end
  end
end