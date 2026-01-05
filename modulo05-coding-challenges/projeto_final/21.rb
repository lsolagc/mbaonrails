def merge_two_lists(list1, list2)
  return if list1.nil? && list2.nil?

  result = ListNode.new()

  el1 = list1 && list1.val.to_f
  el2 = list2 && list2.val.to_f

  case el1 <=> el2
  when -1 # el1 < el2
    result.val = el1
    list1 = list1.next
  when 0 # el1 == el2
    result.val = el1
    list1 = list1.next
  when 1 # el1 > el2
    result.val = el2
    list2 = list2.next
  else
    if el1.nil?
      result.val = el2
      list2 = list2.next
    end

    if el2.nil?
      result.val = el1
      list1 = list1.next
    end
  end

  result.next = merge_two_lists(list1, list2)

  result
end
