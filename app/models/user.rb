class User < ActiveRecord::Base
  has_secure_password
  has_many :consoles
  has_many :games, through: :consoles

  @@signup_errors = []
  @@login_errors = []

  #User Class error methods for signup and login errors

  def self.signup_errors #Holds list of signup errors to tell new user why signup failed
    @@signup_errors
  end

  def self.login_errors #Holds list of login errors to tell existing user why login failed
    @@login_errors
  end

  def self.add_signup_error(error) #
    self.signup_errors << error unless self.signup_errors.include?(error)
  end

  def self.add_login_error(error)
    self.login_errors << error unless self.login_errors.include?(error)
  end

  #User Instance error methods for signup and login errors

  def username_exists? #Checks that username exists
    if self.username == nil || self.username == ""
      signup_error = "You must enter a username."
      self.class.add_signup_error(signup_error)
      false
    else
      true
    end
  end

  def unique_username? #When registering, new user must choose a unique username
    if User.all.find_by(username: self.username)
      signup_error = "Username already exists in the database. Please choose another one."
      self.class.add_signup_error(signup_error)
      false
    else
      true
    end
  end

  def username_different_from_password? #When registering, username must be different from password
    if self.username == self.password
      signup_error = "Your username must be different from your password."
      self.class.add_signup_error(signup_error)
      false
    else
      true
    end
  end

  def valid_username? #Checks that username exists, is unique, and is different from the password
    self.username_exists?
    self.unique_username?
    self.username_different_from_password?
    if self.username_exists? && self.unique_username? && self.username_different_from_password?
      true
    else
      false
    end
  end

  def password_exists? #Checks that password exists
    if self.password != nil
      true
    else
      signup_error = "You must enter a password."
      self.class.add_signup_error(signup_error)
      false
    end
  end

  def valid_password_length? #User password must be between 8 and 25 characters in length
    if !self.password_exists? || self.password.length < 8
      signup_error = "Password must be at least 8 characters."
      self.class.add_signup_error(signup_error)
      false
    elsif self.password.length > 25
      signup_error = "Password must be 25 characters or fewer."
      self.class.add_signup_error(signup_error)
      false
    else
      true
    end
  end

  def required_password_characters? #User password must contain at least one capital letter, one number, and one special character
    capital_letters = /[A-Z]/
    numbers = /[0-9]/
    special_characters = /[!@#$%^&*?-]/
    new_password = self.password
    if capital_letters.match(new_password) && numbers.match(new_password) && special_characters.match(new_password)
      true
    else
      signup_error = "Password must contain at least one capital letter, one number, and one special character."
      self.class.add_signup_error(signup_error)
      false
    end
  end

  def valid_password? #Password must have exist, have a valid length, and contain all the required characters
    self.password_exists?
    self.valid_password_length?
    self.required_password_characters?
    if self.password_exists? && self.valid_password_length? && self.required_password_characters?
      true
    else
      false
    end
  end

end
