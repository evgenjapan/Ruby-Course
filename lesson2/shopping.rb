sum = 0
products = {}
loop do
  puts "Введите 'добавить', чтобы добавить товар"
  puts "Введите 'стоп', если хотите прекратить работу и рассчитать стоимость товаров"
  answer = gets.chomp.downcase
  if answer == 'стоп'
    break
  elsif answer == 'добавить'
    puts 'Введите название'
    name = gets.chomp.capitalize!
    puts 'Введите цену товара'
    price = gets.to_f
    puts 'Введите количество товара'
    quantity = gets.to_f
    products[name] = { price: price, count: quantity }
    sum += price * quantity
    puts "Добавлен продукт #{name} с ценой #{price} в количестве #{quantity} "
  end
end
puts 'Чек:'
products.each { |name, info| puts " #{name} #{info[:price]} #{info[:count]}" }
puts "Итоговая сумма #{sum}"
