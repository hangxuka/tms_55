5.times do |n|
  name = "trainee-#{n+1}"
  email = "trainee-#{n+1}@gmail.com"
  User.create!(name: name, email: email, password: "password",
    password_confirmation: "password", role: 0)
end

User.create(name: "admin", email: "dat@gmail.com", role: 1, 
  password: "123456", password_confirmation: "123456")
