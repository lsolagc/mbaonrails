def roman_to_int(s)
  hash = { 
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000
  }
  res = 0
  process = true

  s.chars.each_with_index do |c, index|
    if process
      nxt = s[index+1]
      if hash[c] < hash[nxt].to_i
        actual = hash[nxt] - hash[c]
        res += actual
        process = false
      else
        res += hash[c]
        process = true
      end
    else
      process = true
    end
  end
  res
end
