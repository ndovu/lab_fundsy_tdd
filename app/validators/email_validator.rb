class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def validate_each(object, attribute, value)
    unless value =~ EMAIL_REGEX
      object.errors[attribute] << (options[:message] || "Not formatted correctly.")
    end
    object.errors
  end
end