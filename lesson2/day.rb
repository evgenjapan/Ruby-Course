months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts"Введите число"
date_day = gets.to_i

puts"Введите месяц (номер месяца)"
date_month = gets.to_i

puts"Введите год"
date_year = gets.to_i

extra = 0
extra = 1 if date_year % 4 == 0 and (date_year % 400 == 0 or date_year % 100 != 0)
days = 0
days += months.take(date_month - 1).sum
days += date_day
days += extra if date_month > 2 # Добавляем день только если февраль уже прошел

puts "В #{date_year} году это был #{days} день "
