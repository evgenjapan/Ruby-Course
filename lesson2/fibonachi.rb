nums = [1,1]
loop do
  nextnum = nums[-1] + nums[-2]
  break if nextnum > 100
  nums << nextnum
end

puts nums
