# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Integer}
def max_depth(root)
  return 0 if root.nil?

  res = 0
  left = max_depth(root.left) + 1
  right = max_depth(root.right) + 1

  res = [left, right].max

  res
end