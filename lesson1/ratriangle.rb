triangle = {}
for i in 0..2
  puts "Введите #{i +1}-ю сторону"
  triangle[i] = gets.chomp.to_f
end
#Проверим на равносторонность и равнобедренность
if triangle[0]==triangle[1] and triangle[1]==triangle[2]
  is_equilateral = true
elsif triangle[0]==triangle[1] or triangle[1]==triangle[2] or triangle[0]==triangle[2]
  is_isosceles = true
end

triangle.sort
is_ra = triangle[0]**2+triangle[1]**2==triangle[2]**2

if is_equilateral
  puts "Ваш треугольник равносторонний"
elsif
  is_isosceles and is_ra
  puts "Ваш треугольник равнобедренный и прямоугольный"
elsif is_isosceles
  puts "Ваш треугольник равнобедренный"
elsif is_ra
  puts "Ваш треугольник прямоугольный"
else
  puts "У вас просто треугольник"
end
