class List
  attr_accessor :head, :tail

  def initialize(head, tail)
    @head = head
    @tail = tail
  end

  def self.empty
    new(nil, nil)
  end

  def inspect
    if empty?
      '[]'
    else
      _inspect(head, tail)
    end
  end

  def prepend(head)
    List.new(head, self)
  end

  def map(&block)
    if empty?
      self
    else
      _map(self, List.empty, &block)
    end
  end

  def reduce(initial, &block)
    _reduce(initial, self, &block)
  end

  def first
    head
  end

  def length
    if empty?
      0
    else
      _length(tail)
    end
  end

  def ==(list)
    head == list.head && tail == list.tail
  end

  def hash
    inspect.hash
  end

  def reverse
    if tail.empty?
      self
    else
      _reverse(self)
    end
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
