class Contact < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :subject
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Contact Form Submission: #{subject}",
      :to => "fabjahr@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end

  def self.subjects
    [
      "Chat + Phone plan",
      "Enterprise plan",
      "Other"
    ]
  end
end
