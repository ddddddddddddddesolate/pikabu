# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "send" do
    let(:user) { create(:user) }
    let(:mail) { described_class.welcome_email(user) }

    it "renders the subject" do
      expect(mail.subject).eql? "Welcome to Pikabu!"
    end

    it "has a valid sender" do
      expect(mail.from).eql? [Rails.application.credentials.mailer[:user_name]]
    end

    it "has a valid recipient" do
      expect(mail.to).eql? [user.email]
    end

    it "renders the body" do
      expect(mail.body.encoded).to match "Welcome to Pikabu, #{user.name}!"
    end
  end
end
