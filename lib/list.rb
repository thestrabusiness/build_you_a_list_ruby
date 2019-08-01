class List
  attr_accessor :head, :tail

  def initialize(head, tail)
    @head = head
    @tail = tail
  end

  def self.empty
    EmptyList.new
  end

  def inspect
    _inspect(head, tail)
  end

  def prepend(head)
    List.new(head, self)
  end

  def map(&block)
    _map(self, List.empty, &block)
  end

  def reduce(initial, &block)
    _reduce(initial, self, &block)
  end

  def first
    head
  end

  def length
    _length(tail)
  end

  def ==(list)
    head == list.head && tail == list.tail
  end

  def hash
    inspect.hash
  end

  def reverse
    _reverse(self)
  end

  protected

  def empty?
    tail.nil? && head.nil?
  end

  private

  def _length(remaining_tail, count = 0)
    if remaining_tail.nil?
      count
    else
      count += 1
      _length(remaining_tail.tail, count)
    end
  end

  def _inspect(current_head, remaining_tail, list_values = '')
    list_values << "#{current_head}"
    if remaining_tail.nil?
      list_values.prepend('[') + ']'
    else
      list_values << ", " unless remaining_tail.head.nil?
      _inspect(remaining_tail.head, remaining_tail.tail, list_values)
    end
  end

  def _map(current_list, new_list, &block)
    if current_list.empty?
      new_list.reverse
    else
      new_head = block.call current_list.head
      list = new_list.prepend(new_head)
      _map(current_list.tail, list, &block)
    end
  end

  def _reverse(current_list, new_list = List.empty)
    if current_list.empty?
      new_list
    else
      list = new_list.prepend(current_list.head)
      _reverse(current_list.tail, list)
    end
  end

  def _reduce(current_value, current_list, &block)
    if current_list.empty?
      current_value
    else
      new_value = block.call(current_value, current_list.head)
      _reduce(new_value, current_list.tail, &block)
    end
  end
end


class EmptyList
  def prepend(value)
    List.new(value, self)
  end

  def empty?
    true
  end

  def inspect
    '[]'
  end

  def map
    self
  end

  def length
    0
  end

  def reverse
    self
  end

  def first
    nil
  end

  def reduce(value)
    value
  end

  def head
    nil
  end

  def tail
    nil
  end

  def ==(other_list)
    other_list.empty?
  end
end
