puts "Введите длину основания треугольника"
a = gets.chomp.to_f #Сделал to_f, чтобы иметь возможность считать числа меньше 1
puts "Введите высоту треугольника"
h = gets.chomp.to_f
puts "Площадь вашего треугольника равна #{0.5*a*h}"