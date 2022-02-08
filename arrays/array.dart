abstract class Array<E> {
  void insert(E value);
  void delete(E value);
  // int indexAt(E value);
  // E deleteAt(int index);
}

class ArrayList<E> extends Array<E> {
  List _list = new List.filled(5, 0);
  int _counter = 0;

  /// Insert an item of time [E]
  void insert(E value) {
    _list[_counter++] = value;
  }

  /// Delete an item given an index of tipe [int]
  void deleteAt(int index) {
    if (index >= _counter) throw Exception("Out of range");
    _counter--;
    _shiftArray(index: index);
  }

  /// Delete an item given an index of tipe [int]
  void delete(E value) {
    int index = indexAt(value);
    if (index == -1) throw Exception('Item is not in the array');
    // if item is present in array, then shift the array
    _counter--;
    _shiftArray(index: index);
  }

  int indexAt(E value) {
    // return if item to delete is at the end of the array
    if (_list[_counter - 1] == value) {
      _list[_counter - 1] = 0;

      // return last index
      return _counter - 1;
    }

    for (int i = 0; i < _counter; i++) {
      if (_list[i] == value) {
        return i;
      }
    }

    return -1;
  }

  bool isItemInArray(E value) {
    if (indexAt(value) != -1)
      return true;
    else
      return false;
  }

  void _shiftArray({required int index}) {
    // O(n)
    for (int j = index; j < _counter; j++) {
      _list[j] = _list[j + 1];
    }
  }

  @override
  String toString() {
    print(_list);
    return "List";
  }
}

void main() {
  ArrayList<String> list = ArrayList();

  list.insert("10");
  list.insert("20");
  list.insert("30");
  list.insert("40");
  list.insert("50");

  print(list.indexAt("10"));
  list.delete("10");

  print(list);
}
