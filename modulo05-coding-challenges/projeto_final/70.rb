# @param {Integer} n
# @return {Integer}
def climb_stairs(n)
  @fibo_array ||= [1, 1]

  return @fibo_array[n] if @fibo_array[n]

  @fibo_array[n] = climb_stairs(n-1) + climb_stairs(n-2)
end
