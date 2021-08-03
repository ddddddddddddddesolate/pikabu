# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "send" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.welcome_email(user) }

    it "renders the headers" do
      expect(mail.subject).eql? "Welcome to Pikabu!"
      expect(mail.from).eql? [Rails.application.credentials.mailer[:user_name]]
      expect(mail.to).eql? [user.email]
    end

    it "renders the body" do
      expect(mail.body.encoded).to match "Welcome to Pikabu, #{user.name}!"
    end
  end
end
