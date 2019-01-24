alphabet = ('a'..'z').to_a
vowels = %w(a e i o u y)
hash = {}
alphabet.each_with_index do |letter, i|
  hash[letter] = i + 1 if vowels.include?(letter)
end
puts hash
