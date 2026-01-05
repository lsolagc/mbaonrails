def remove_duplicates(nums)
  uniq_index = 0
  last_uniq = nil

  nums.each do |i|
    next if last_uniq == i

    last_uniq = i
    nums[uniq_index] = i

    uniq_index += 1
  end

  uniq_index
end
