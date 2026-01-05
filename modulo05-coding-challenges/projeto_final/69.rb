# @param {Integer} x
# @return {Integer}
def my_sqrt(x)
  return 0 if x == 0
  return 1 if x == 1

  lower_boundary = 0
  upper_boundary = x.to_f
  suggested_answer = 0

  loop do
    suggested_answer = (lower_boundary + upper_boundary) / 2
  
    tested_square = suggested_answer * suggested_answer
      
    if tested_square > x
      upper_boundary = suggested_answer
    else
      lower_boundary = suggested_answer
    end
  
    if lower_boundary.floor == upper_boundary.floor
      break
    end
  end

  suggested_answer.floor
end
