import 'dart:math';

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

// ------- Public ----------

  void swapChilds() {
    if (_root == null) throw Exception("Root is empty");

    var temp = _root!.leftChild;
    _root!.leftChild = _root!.rightChild;
    _root!.rightChild = temp;
  }

  bool validate() => _validate(_root, double.negativeInfinity, double.infinity);

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

  void levelOrderTraversal() {
    for (var i = 0; i <= hight(); i++) {
      getNodesAtDistance(i).forEach((print));
    }
  }

  void traversePreOrder() {
    _traversePreOrder(_root);
  }

  void traversePostOrder() {
    _traversePostOrder(_root);
  }

  void traverseInOrder() {
    _traverseInOrder(_root);
  }

  int hight() {
    _exception();
    return _hight(_root);
  }

  int minValue() {
    _exception();
    return _minValue(_root);
  }

// finding the min value using binary search
  int minSearch() {
    _exception();
    var current = _root;
    // mantain a reference to the last item in the tree before stopping a loop
    var last = current;

    while (current != null) {
      last = current;
      current = current.leftChild;
    }

    return last!.value;
  }

  List<int> getNodesAtDistance(int distance) {
    List<int> list = [];
    _getNodesAtDistance(_root, distance, list);

    return list;
  }

// ------- Private ---------

  bool _validate(_Node? root, num min, num max) {
    if (root != null) {
      return root.value >= min &&
          root.value <= max &&
          _validate(root.leftChild, min, root.value) &&
          _validate(root.rightChild, root.value, max);
    }

    return true;
  }

  bool _equals(_Node? root, _Node? other) {
    if (root == null && other == null) return true;

    if (root != null && other != null) {
      return root.value == other.value &&
          _equals(root.leftChild, other.leftChild) &&
          _equals(root.rightChild, other.rightChild);
    }

    return false;
  }

  Exception? _exception() {
    return _root == null
        ? throw Exception(
            "Root is null, try adding a value before calling this method")
        : null;
  }

  bool _isLeaf(_Node? root) {
    if (root == null) return false;

    return root.leftChild == null && root.rightChild == null;
  }

  int _minValue(_Node? root) {
    if (_isLeaf(root)) return root!.value;

    return min(min(_minValue(root!.leftChild), _minValue(root.rightChild)),
        root.value);
  }

  int _hight(_Node? root) {
    if (_isLeaf(root) || root == null) return 0;

    return 1 + max(_hight(root.leftChild), _hight(root.rightChild));
  }

  void _traversePreOrder(_Node? root) {
    if (root == null) return;
    print(root.value);
    _traversePreOrder(root.leftChild);
    _traversePreOrder(root.rightChild);
  }

// 3, 6, 8, 10, 14, 20, 24, 26, 30
  void _traverseInOrder(_Node? root) {
    if (root == null) return;

    _traverseInOrder(root.leftChild);
    print(root.value);
    _traverseInOrder(root.rightChild);
  }

  void _traversePostOrder(_Node? root) {
    if (root == null) return;

    _traversePostOrder(root.leftChild);
    _traversePostOrder(root.rightChild);
    print(root.value);
  }

  void _getNodesAtDistance(_Node? root, int distance, List<int> list) {
    if (root == null) return;
    if (distance == 0) {
      list.add(root.value);

      return;
    }

    _getNodesAtDistance(root.leftChild, distance - 1, list);
    _getNodesAtDistance(root.rightChild, distance - 1, list);
  }

// overrides
  @override
  bool operator ==(covariant Tree<int> other) => _equals(_root, other._root);
}

void main() {
  Tree<int> tree = Tree();
  Tree<int> treeV2 = Tree();

  // Tree v1
  tree.insert(20);
  tree.insert(10);
  tree.insert(30);
  tree.insert(6);
  tree.insert(14);
  tree.insert(24);
  tree.insert(22);
  tree.insert(26);
  // Tree v2
  treeV2.insert(20);
  treeV2.insert(10);
  treeV2.insert(30);
  treeV2.insert(6);
  treeV2.insert(14);
  treeV2.insert(24);

  //tree.traverseInOrder();
  // print(tree.minValue());
  // print(tree.minSearch());

//------ Equals ------
  // print(tree == treeV2);

//------ Validate ------
  // print(tree.validate());
  // tree.swapChilds();
  // print(tree.validate());

//------ Kth Distance -----
  var nodeList = tree.getNodesAtDistance(3);
  //print(nodeList);

//------ Lvl Order Traversal
  tree.levelOrderTraversal();
}
