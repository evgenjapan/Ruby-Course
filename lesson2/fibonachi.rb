nums = [1]
num = 1
i = 1
while num < 100
  nums << num
  num = nums[i] + nums[i-1]
  i += 1
end
puts nums

