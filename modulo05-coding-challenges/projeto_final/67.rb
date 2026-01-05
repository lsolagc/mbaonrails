# @param {String} a
# @param {String} b
# @return {String}
def add_binary(a, b)
  a, b = [a.to_i(2), b.to_i(2)]
  (a + b).to_s(2)
end
