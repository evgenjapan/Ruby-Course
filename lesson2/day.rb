months = {"1" => 31, "2" => 28, "3" => 31, "4" => 30,"5" => 31, "6" => 30,
        "7" => 31, "8" => 31, "9" => 30, "10" => 31, "11" => 30, "12" => 31}

puts"Введите число"
dateDay = gets.chomp.to_i

puts"Введите месяц (номер месяца)"
dateMonth = gets.chomp.to_i

puts"Введите год"
dateYear = gets.chomp.to_i

extra = 0
extra = 1 if dateYear % 4 == 0 and (dateYear % 400 == 0 or dateYear % 100 != 0)
days = 0
i = 1
while i < dateMonth
  days += months[i.to_s]
  i += 1
end
days += dateDay + extra

puts days
