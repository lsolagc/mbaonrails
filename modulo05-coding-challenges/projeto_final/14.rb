def longest_common_prefix(strs)
  prefix = []

  chars = strs.map(&:chars).sort{|a, b| a.size <=> b.size}

  chars[0].each_index do |index|
    common = chars.map{|i| i[index]}.uniq.size == 1
    break unless common
    prefix << chars[0][index] if common
  end

  prefix.join
end
