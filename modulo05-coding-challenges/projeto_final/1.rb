def two_sum(nums, target)
  res = []
  nums.each_with_index do |n, index|
    c = target - n
    index2 = nums[(index+1)..].index(c)
    if index2
      res = [index, index+index2+1]
      break
    end
  end

  res
end