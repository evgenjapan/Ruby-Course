
puts "Введите значение a"
a = gets.chomp.to_f
puts "Введите значение b"
b = gets.chomp.to_f
puts "Введите значение c"
c = gets.chomp.to_f

d = b**2 - 4*a*c
if d < 0
  puts "Дискриминант: #{d}. Корней нет"
elsif d == 0
  puts "Дискриминант: #{d}. Корень равен #{-b/(2*a)} "
else
  puts "Дискриминант: #{d}. Первый корень равен #{(-b + Math.sqrt(d))/(2*a)}, а второй #{(-b - Math.sqrt(d))/(2*a)}"
end