class CareerAdviceRequest
  include ActiveModel::Validations

  validates_presence_of :name, :email

  # to deal with form, you must have an id attribute
  attr_accessor :id, :name, :email, :skype, :background, :thoughts, :questions, :mailing_list

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
      CareerAdviceRequestMailer.career_advice_request_email(name,email,skype,background,thoughts,questions,mailing_list).deliver!
      return true
    end
    return false
  end

  def persisted?
    false
  end
end
