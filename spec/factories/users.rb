FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'f4k3p455w0rd'
    encrypted_password Devise::Encryptor.digest(User, "f4k3p455w0rd")
  end
end
