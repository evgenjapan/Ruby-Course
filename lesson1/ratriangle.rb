triangle = {}
(0..2).each do |i|
  puts "Введите #{i + 1}-ю сторону"
  triangle[i] = gets.chomp.to_f
end

if (triangle[0] == triangle[1]) && (triangle[1] == triangle[2])
  is_equilateral = true
elsif (triangle[0] == triangle[1]) || (triangle[1] == triangle[2]) || (triangle[0] == triangle[2])
  is_isosceles = true
end

triangle.sort
is_ra = triangle[0]**2 + triangle[1]**2 == triangle[2]**2

if is_equilateral
  puts 'Ваш треугольник равносторонний'
elsif is_isosceles && is_ra
  puts 'Ваш треугольник равнобедренный и прямоугольный'
elsif is_isosceles
  puts 'Ваш треугольник равнобедренный'
elsif is_ra
  puts 'Ваш треугольник прямоугольный'
else
  puts 'У вас просто треугольник'
end
