class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

end

  class Tree
    attr_accessor :root

    def initialize(array = [])
      @root = build_tree(array.uniq.sort, 0, array.uniq.length - 1)
    end

  def build_tree(array, start, final)
    return if start > final
    mid = (start + final) / 2
    
    node = Node.new(array[mid])
    node.left = build_tree(array, start, mid - 1)
    node.right = build_tree(array, mid + 1, final)
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(key, root = @root)
    if root.nil?
      return Node.new(key)
    else
      if root.data == key
        return root
      elsif root.data < key
        root.right = insert(key, root.right)
      else
        root.left = insert(key, root.left)
      end
    end
    return root
  end

  def delete(key)
    root = deleterec(key)
  end

  def deleterec(key, root = @root)
    if root.nil?
      return root
    end
    if key < root.data
      root.left = deleterec(key, root.left)
    elsif
      key > root.data
      root.right = deleterec(key, root.right)
    else
      if root.left.nil?
        return root.right
      elsif
        root.right.nil?
        return root.left
      end
      root.data = min_value(root.right)
      root.right = deleterec(root.data, root.right)
    end
    return root
  end

  def min_value(root)
    minv = root.data
    until root.left.nil?
      minv = root.left.data
      root = root.left
    end
    return minv
  end

  def find(value, root = @root)
    find_rec(value, root)  
  end

  def find_rec(value, root)
    return root if root.nil?
    if root.data < value
      root = find_rec(value, root.right)
    elsif root.data > value
      root = find_rec(value, root.left)
    else
      return root
    end
    root
  end

  def level_order
    queue = [@root]
    ordered_array = []
    until queue == []
      elem = queue.shift
      ordered_array.push(elem.data)
      queue << elem.left unless elem.left.nil?
      queue << elem.right unless elem.right.nil?
    end
    block_given? ? ordered_array.each {|elem| yield elem} : ordered_array    
  end

  def rec_level_order    
    array = level_rec(@root, queue = [], array =[])
    block_given? ? array.each {|elem| yield elem} : array
  end

  def level_rec(root, queue, array)
    return if root.nil?
    
    array << root.data
    
    queue << root.left unless root.left.nil?
    queue << root.right unless root.right.nil?

    level_rec(queue.shift, queue, array) unless queue.empty?
    array

  end 
  
  def height(value = @root.data)
    node = find(value)
    i = -1
    defHeight(node, i) unless node.nil?
  end

  def defHeight(node, i)
    return i if node.nil?
    ri = defHeight(node.right, i + 1)
    li = defHeight(node.left, i + 1)
    return ri >= li ? ri : li
  end

  def balanced?
    return if @root.nil?
    left_height = defHeight(@root.left, -1)
    right_height = defHeight(@root.right, -1)
    (left_height - right_height).abs < 2
  end

  def depth(value)
    return nil unless find(value)
    node = @root
    i = 0
    depth_rec(node, value, i, dep = 0)
  end

  def depth_rec(node, value, i, dep)
    return dep if node.nil?    
    dep = i if node.data == value
    ri = depth_rec(node.right, value, i + 1, dep)
    le = depth_rec(node.left, value, i + 1, dep)
    ri > le ? dep = ri : dep = le
    dep
  end

  def inorder
    array = inorder_rec(@root, array = [])
    block_given? ? array.each {|elem| yield elem} : array
  end

  def inorder_rec(root, array)
    return if root.nil?
    inorder_rec(root.left, array)
    array << root.data
    inorder_rec(root.right, array)
    array
  end

  def preorder
    array = preorder_rec(@root, array = [])
    block_given? ? array.each {|elem| yield elem} : array
  end

  def preorder_rec(root, array)
    return if root.nil?
    array << root.data
    preorder_rec(root.left, array)    
    preorder_rec(root.right, array)
    array
  end

  def postorder
    array = postorder_rec(@root, array = [])
    block_given? ? array.each {|elem| yield elem} : array
  end

  def postorder_rec(root, array)
    return if root.nil?
    postorder_rec(root.left, array)    
    postorder_rec(root.right, array)
    array << root.data
    array
  end

  def rebalance
    array = rec_level_order
    @root = build_tree(array.uniq.sort, 0, array.uniq.length - 1)
  end

end

array = Array.new(15) {rand(1..100)}

bsb = Tree.new(array)
bsb.pretty_print
puts "is balanced?: #{bsb.balanced?}"
puts "\nlevel order: #{bsb.rec_level_order}"
puts "pre order: #{bsb.preorder}"
puts "post order: #{bsb.postorder}"
puts "in order: #{bsb.inorder}"
puts "\n\nadd 105, 140, 180, 200"
bsb.insert 105
bsb.insert 140
bsb.insert 180
bsb.insert 200
puts "\nis balanced now? #{bsb.balanced?}"
puts "\nrebalance !"
bsb.rebalance
puts "\nand now? is balanced?: #{bsb.balanced?}"
puts "\n\nlevel order: #{bsb.rec_level_order}"
puts "pre order: #{bsb.preorder}"
puts "post order: #{bsb.postorder}"
puts "in order: #{bsb.inorder}"
