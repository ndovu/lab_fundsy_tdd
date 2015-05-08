require 'rails_helper'

RSpec.describe User, type: :model do
  
  def valid_attributes(new_attributes = {}) 
    attributes = {first_name: "Noel",
                  last_name: "Bacani",
                  email: "noel.bacani@gmail.com",
                  password: "abcd1234"}
    attributes.merge(new_attributes)
  end

  describe "Validations" do
    it 'requires an email' do
      user = User.new(valid_attributes({email: nil}))
      expect(user).to be_invalid
    end

    it 'requires a first name' do
      user = User.new(valid_attributes({first_name: nil}))
      expect(user).to be_invalid
    end

    it 'requires a unique email' do
      # Create a user with email in memory
      User.create(valid_attributes)
      # Try to create another user with the same email. Should throw an error
      user = User.new(valid_attributes)
      user.save
      expect(user.errors.messages).to have_key(:email)
    end

    it 'requires a valid email' do
      user = User.new(valid_attributes({email: 'not_a_valid_email'}))
      expect(user).to be_invalid
    end
  end

  describe "Hasing the password" do
    it 'generates a password digest if provided a password' do
      user = User.new(valid_attributes)
      user.save
      # Relies on bcyrpt
      expect(user.password_digest).to be
    end
  end

  describe ".full_name" do
    it 'returns a concatenated full name if both the first and last name are provided' do
      user = User.new(valid_attributes)
      expect(user.full_name).to eq("#{valid_attributes[:first_name]} #{valid_attributes[:last_name]}")
    end

    it 'returns the first name only if only the first name is provided' do
      user = User.new(valid_attributes({last_name: nil}))
      expect(user.full_name).to eq("#{valid_attributes[:first_name]}")
    end
  end


end
