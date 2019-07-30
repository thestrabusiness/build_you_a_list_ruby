require "list"

describe List do
  describe "#inspect" do
    it "shows empty brackets for an empty list" do
      expect(List.empty.inspect).to eq "[]"
    end

    it "shows a value in brackets for a single item" do
      list = List.empty.prepend 1

      expect(list.inspect).to eq "[1]"
    end

    it "shows bracketed values separated by commas for multiple items" do
      list = List.empty.prepend(3).prepend(2).prepend(1)

      expect(list.inspect).to eq "[1, 2, 3]"
    end
  end

  describe "#length" do
    it "is zero when the list is empty" do
      expect(List.empty.length).to eq 0
    end

    it "is the number of items in the list" do
      list = List.empty.prepend(3).prepend(2).prepend(1)

      expect(list.length).to eq 3
    end
  end

  describe "#first" do
    it "returns nil for an empty list" do
      expect(List.empty.first).to be_nil
    end

    it "returns the only item for a singleton list" do
      list = List.empty.prepend(1)

      expect(list.first).to eq 1
    end

    it "returns the first value for multi-value list" do
      list = List.empty.prepend(1).prepend(2).prepend(3)

      expect(list.first).to eq 3
    end
  end

  describe "#map" do
    # In fancy FP speak, these two tests are called the "functor laws"
    # All map functions must pass these to be considered legit

    it "does nothing when mapping itself" do
      list = List.empty.prepend(3).prepend(2).prepend(1)

      expect(list.map(&:itself)).to eq list
    end

    it "treats map chains just like a single map with a composed function" do
      list = List.empty.prepend(3).prepend(2).prepend(1)

      chained = list.map { |n| n * 2 }.map { |n| n.to_string }
      composed = list.map { |n| (n * 2).to_string }

      expect(chained).to eq composed
    end
  end

  describe "#reduce" do
    it "returns the initial value if the list is empty" do
      list = List.empty

      sum = list.reduce(0) { |memo, n| memo + n }

      expect(sum).to eq 0
    end

    it "can sum a multi-item list" do
      list = List.empty.prepend(3).prepend(2).prepend(1)

      sum = list.reduce(0) { |memo, n| memo + n }

      expect(sum).to eq 6
    end

    it "check if all items are even" do
      list = List.empty.prepend(3).prepend(2).prepend(1)

      all_even = list.reduce(true) { |memo, n| memo && n.even? }

      expect(all_even).to eq true
    end
  end
end
