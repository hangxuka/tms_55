5.times do |n|
  name = "trainee-#{n+1}"
  email = "trainee-#{n+1}@gmail.com"
  User.create!(name: name, email: email, password: "password",
    password_confirmation: "password", role: 0)
end

5.times do |n|
  user_id = 1
  course_id = n+1
  UserCourse.create!(user_id: user_id, course_id: course_id)
end

5.times do |n|
  user_id = 6
  course_id = n+1
  UserCourse.create!(user_id: user_id, course_id: course_id)
end

User.create(name: "user", email: "user@gmail.com", role: 0,
  password: "123456", password_confirmation: "123456")
User.create(name: "admin", email: "dat@gmail.com", role: 1,
  password: "123456", password_confirmation: "123456")
User.create(name: "admin", email: "adminluyen@gmail.com", role: 2,
  password: "123456", password_confirmation: "123456")
