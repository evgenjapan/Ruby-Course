alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
vowels = "аеёиоуыэюя"
hash = Hash.new

vowels.each_char do |vowel|
  i = 1
  alphabet.each_char do |letter|
    if vowel == letter
      hash[vowel] = i
    end
    i += 1
  end
end
puts hash
