def add_two_numbers(l1, l2)
  resultado = dummy = ListNode.new
  carry = 0
  continuar = true

  while continuar
    el1 = l1 ? l1.val : 0
    el2 = l2 ? l2.val : 0
    temp = el1 + el2 + carry
    carry = temp / 10
    dummy.val = temp % 10

    l1 = l1.next if l1
    l2 = l2.next if l2
    continuar = l1 || l2 || (carry > 0)

    dummy = dummy.next = ListNode.new if continuar
  end

  resultado
end
