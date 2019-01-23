sum = 0
loop do
  puts "Введите 'добавить', чтобы добавить товар"
  puts "Введите 'стоп', если хотите прекратить работу и рассчитать стоимость товаров"
  answer = gets.chomp.downcase
  products = Hash.new { |h, k| h[k] = Hash.new }
  if answer == "стоп"
    break
  elsif answer == "добавить"
    puts "Введите название"
    name = gets.chomp.capitalize!
    puts "Введите цену товара"
    price = gets.chomp.to_f
    puts "Введите количество товара"
    quantity = gets.chomp.to_f
    products[name][price] = quantity
    sum += price*quantity

  end
  puts products
end
puts sum
