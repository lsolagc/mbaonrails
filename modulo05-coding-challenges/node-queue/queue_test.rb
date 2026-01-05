require "minitest/autorun"
require_relative "./queue"

class QueueTest < Minitest::Test
  def test_new_queue_from_array
    queue = Queue.new([random_number, random_number, random_number])
    assert_equal queue.size, 3, "queue size is not 3"
  end

  def test_size_increases_when_value_is_pushed
    queue = Queue.new

    queue.push(random_number)
    assert_equal queue.size, 1, "queue size is not 1"

    queue.push(random_number)
    assert_equal queue.size, 2, "queue size is not 2"
  end

  def test_size_decreases_when_value_is_popped
    queue = Queue.new([random_number, random_number])

    queue.pop
    assert_equal queue.size, 1, "queue size is not 1"

    queue.pop
    assert_equal queue.size, 0, "queue size is not 0"
  end

  def test_pop_returns_values_in_correct_order
    first = random_number
    second = random_number
    third = random_number

    queue = Queue.new([first, second, third])

    assert_equal queue.pop, first, "popped value did not match #{first}"
    assert_equal queue.pop, second, "popped value did not match #{second}"
    assert_equal queue.pop, third, "popped value did not match #{third}"
  end

  def test_front_returns_head_value_and_does_not_change_size
    first = random_number
    second = random_number
    third = random_number

    queue = Queue.new([first, second, third])

    assert_equal queue.size, 3, "queue size is not 3"
    assert_equal queue.front, first, "front value did not match #{first}"
    assert_equal queue.size, 3, "queue size is not 3 after calling Queue#front"
  end

  def test_empty_queue_pops_nil
    queue = Queue.new

    assert_equal queue.pop, nil, "empty queue did not return nil"
  end

  private

  def random_number
    rand(1..100)
  end
end
