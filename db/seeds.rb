10.times do |blog|
  Blog.create!(title: "#{blog} title", date: Date.today, body: "#{blog} content here")
end

puts "10 blogs created"