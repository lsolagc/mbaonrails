def int_to_roman(num)
  hash = { 
    '1' => 'I',
    '5' => 'V',
    '10' => 'X',
    '50' => 'L',
    '100' => 'C',
    '500' => 'D',
    '1000' => 'M'
  }
  repeatable = {
    '1' => 'I',
    '10' => 'X',
    '100' => 'C',
    '1000' => 'M'
  }
  sub_forms = {
    '4' => 'IV',
    '9' => 'IX',
    '40' => 'XL',
    '90' => 'XC',
    '400' => 'CD',
    '900' => 'CM',
  }
  chars = num.to_s.chars 
  composition = chars.reverse.map.with_index { |c, i| (c.to_i * (10 ** i)) }
  result = []

  composition.each_with_index do |el, i|
    if sub_forms[el.to_s]
      result << sub_forms[el.to_s]
      next
    end

    int = hash.keys.reverse.detect{ |k| (el - k.to_i) >= 0 }
    el = el - int.to_i
    
    repeats = (el / (10 ** i))
    if repeats <= 3
      int2 = repeatable.keys.detect{ |k| (el / k.to_i) < 10 }
      roman = repeatable[int2]
      result << (roman * repeats)
      result << hash[int]
      next
    end
  end
  result.reverse.join
end
