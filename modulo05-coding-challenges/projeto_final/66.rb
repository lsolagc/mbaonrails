# @param {Integer[]} digits
# @return {Integer[]}
def plus_one(digits)
  digits = digits.reverse
  
  index = 0
  loop do
    num = digits[index]
    num += 1
  
    digits[index] = num % 10
    carry = num / 10

    break if carry == 0

    if (index + 1) == digits.length
      digits << carry 
      break
    end
    
    index += 1
  end

  digits.reverse
end
