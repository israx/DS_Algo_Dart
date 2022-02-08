class _Node {
  int value;
  _Node({
    required this.value,
  });

  _Node? leftChild;
  _Node? rightChild;
}

class Tree<E> {
  _Node? _root;

  void insert(int value) {
    var newNode = _Node(value: value);
    if (_root == null) {
      _root = newNode;
      return;
    }

    var current = _root;
    while (true) {
      if (current!.value > value) {
        if (current.leftChild == null) {
          current.leftChild = newNode;
          break;
        }
        current = current.leftChild;
      } else {
        if (current.rightChild == null) {
          current.rightChild = newNode;
          break;
        }
        current = current.rightChild;
      }
    }
  }

  bool find(int value) {
    var current = _root;

    while (current != null) {
      if (current.value > value) {
        if (current.value == value) return true;

        current = current.leftChild;
      } else {
        if (current.value == value) return true;

        current = current.rightChild;
      }
    }
    return false;
  }

  // 20, 10, 30, 6, 14, 24, 3, 8, 26
  List<int> breadthFirst() {
    List<int> list = [];
    var current = _root;
    list.add(current!.value);
    while (current != null) {
      list.add(current.leftChild!.value);
      list.add(current.rightChild!.value);
    }

    return list;
  }

// PreOrder
  void traversePreOrder() {
    _traversePreOrder(_root);
  }

  void _traversePreOrder(_Node? root) {
    if (root == null) return;
    print(root.value);
    _traversePreOrder(root.leftChild);
    _traversePreOrder(root.rightChild);
  }

  void _traverseInOrder(_Node? root) {
    // left
    // root
    // right
  }

  void traversePostOrder() {
    _traversePostOrder(_root);
  }

  int? _traversePostOrder(_Node? root) {
    if (root!.leftChild == null || root.rightChild == null) {
      print(root.value);
      return root.value;
    }

    _traversePostOrder(root.leftChild);
    _traversePostOrder(root.rightChild);
  }
}

void main() {
  Tree<int> tree = Tree();
  tree.insert(20);
  tree.insert(10);
  tree.insert(30);
  tree.insert(6);
  tree.insert(14);
  tree.insert(24);
  tree.insert(3);
  tree.insert(8);
  tree.insert(26);

  tree.traversePostOrder();
}