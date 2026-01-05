# @param {String} s
# @return {Integer}
def length_of_last_word(s)
  s.strip.split(' ')[-1].length
end