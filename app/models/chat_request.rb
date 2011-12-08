class ChatRequest
  include ActiveModel::Validations

  validates_presence_of :name, :email

  # to deal with form, you must have an id attribute
  attr_accessor :id, :name, :email, :skype, :phone, :options_career, :options_joining, :options_questions, :options_other, :other_text

  def initialize(attributes = {})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end
 
  def to_key
  end

  def save
    if self.valid?
      options = {:career => options_career, 
                 :joining => options_joining,
                 :questions => options_questions,
                 :other => options_other,
                 :other_text => other_text }
      ChatRequestMailer.chat_request_email(name,email,phone,skype,options).deliver!
      return true
    end
    return false
  end
end
