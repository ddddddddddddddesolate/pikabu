# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: "pikabu@purrweb.com"

  def welcome_email(user)
    @user = user

    mail to: user.email, subject: "Welcome to Pikabu!"
  end
end
