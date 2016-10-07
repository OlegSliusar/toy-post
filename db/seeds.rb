User.create!(name:  "Oleh Sliusar",
             email: "oleh@olehsliusar.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

names_emails = {}

9.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  name = "#{first_name} #{last_name}"
  email = "#{first_name.downcase.tr('\'', '') + last_name.tr('\'', '').downcase}@olehsliusar.com" 
  if names_emails.has_value?(email)
    redo
  end
  names_emails[name] = email
  # Implement somehow alphabet sorting
end

names_emails.each do |name, email|
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(10)
#50.times do
users.each do |user|
  content = Faker::PhoneNumber.phone_number # Lorem.sentence(5)
  content = "Call me #{content}"
  # users.each { |user| 
  user.microposts.create!(content: content) #}
end
