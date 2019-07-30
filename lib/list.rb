class List
  def self.empty
    new
  end

  def prepend(value)
    self
  end

  def map(&block)
    self
  end

  def reduce(initial, &block)
  end

  def first
  end

  def length
  end

  def inspect
    "[]"
  end
end
