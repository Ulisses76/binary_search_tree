class Node
  attr_accessor :node, :left, :rigth

  def initialize(d)
    @data = d
    @left = nil
    @rigth = nil
    root = nil
  end

end

  def build_tree(array, start, final)
    return if start > final
    mid = (start + final) / 2
    
    node = Node.new(array[mid])
    node.left = build_tree(array, start, mid - 1)
    node.rigth = build_tree(array, mid + 1, final)
    node
  end



array = [1,2,3,4,5]

root = build_tree(array, 0, array.length - 1)

p root.left.rigth
p root.rigth.rigth