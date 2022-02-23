class Heap {
  List<int> _list = [];

//       20
//     10
//   40
//  50
  void add(int value) {
    _list.add(value);

    _bubbleUp();
  }

// 20, 6, 10, 1, 2
  void delete() {
    _exceptionListEmpty();

    _list[0] = _list.removeLast();

    _bubbleDown();
  }

  void _bubbleUp() {
    var index = _list.length - 1;

    while (index > 0 && _list[index] > _list[_parentIndex(index)]) {
      _swap(index, _parentIndex(index));
      index = _parentIndex(index);
    }
  }

  void _bubbleDown() {
    var index = 0;

    while (index < _list.length &&
        _list[index] < _leftChild(index) &&
        _list[index] < _rightChild(index)) {
      var largerChildIndex = _leftChild(index) > _rightChild(index)
          ? _leftChildIndex(index)
          : _rightChildIndex(index);

      _swap(index, largerChildIndex);
      index = largerChildIndex;
    }
  }

  int _leftChild(int index) => _list[_leftChildIndex(index)];
  int _rightChild(int index) => _list[_rightChildIndex(index)];

  int _leftChildIndex(int index) => index * 2 + 1;

  int _rightChildIndex(int index) => index * 2 + 2;

  int _parentIndex(int index) {
    var parent = (index - 1) / 2;
    return parent.toInt();
  }

  void _swap(int indexA, int indexB) {
    var temp = _list[indexA];
    _list[indexA] = _list[indexB];
    _list[indexB] = temp;
  }

  void _exceptionListEmpty() {
    if (_list.isEmpty) throw Exception("List is empty");
  }

  @override
  String toString() {
    return _list.toString();
  }
}

void main() {
  Heap heap = Heap();
  heap.add(6);
  heap.add(1);
  heap.add(5);
  heap.add(2);
  heap.add(10);
  heap.add(20);
  heap.add(3);
  heap.add(21);
  heap.add(33);

  print(heap);

  heap.delete();

  print(heap);
}
