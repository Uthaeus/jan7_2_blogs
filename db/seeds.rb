
@user = User.create(email: "test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Jim", last_name: "Beam")

puts "1 user created"

10.times do |blog|
  Blog.create!(title: "#{blog} title", date: Date.today, body: "#{blog} content here")
end

puts "10 blogs created"