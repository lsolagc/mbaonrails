# @param {String} s
# @return {Boolean}
def is_valid(s)
  hash_open = {
    "(" => ")",
    "[" => "]",
    "{" => "}"
  }
  hash_close = hash_open.invert
  open = []
  started = false

  s.chars.each do |c|
    if hash_open.key?(c)
      started = true
      open << c
    else
      if hash_close.key?(c) && !open.include?(hash_close[c])
        return false
      else
        if hash_close.key?(c) && hash_close[c] == open.last
          open.pop
        end
      end
    end
    break unless started
  end

  started && open.empty?
end
