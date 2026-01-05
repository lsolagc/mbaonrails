# Confesso que achei esse muito difícil e acabei copiando a solução do editorial e entendendo ela depois
# 
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
# @return {Integer[]}
def inorder_traversal(root)
  stack = []
  res = []
  curr = root

  while curr || !stack.empty?
    while curr
      stack << curr
      curr = curr.left
    end

    curr = stack.pop
    res << curr.val
    curr = curr.right
  end

  res
end
