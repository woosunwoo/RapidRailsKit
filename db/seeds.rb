# db/seeds.rb
user = User.last || User.create!(email: "test@example.com", password: "password")

5.times do |i|
  Project.create!(
    name: "Project #{i + 1}",
    description: "This is project number #{i + 1}.",
    user: user
  )
end

other_user = User.create!(
  email: "intruder@example.com",
  password: "password",
  password_confirmation: "password"
)

other_user.projects.create!(
  name: "Hacked Project",
  description: "Should not be accessible by others"
)
