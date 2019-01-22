puts "Как вас зовут?"
name = gets.chomp.capitalize!
puts "Какой у вас рост?"
height = gets.chomp.to_i
if (height-110).positive?
  puts "#{name}, ваш идеальный вес составляет #{height - 110}"
else
  puts "Ваш вес уже оптимальный"
end
