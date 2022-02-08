import 'dart:collection';

/// Object holding keys and values
class Entry extends LinkedListEntry<Entry> {
  final int key;
  final String value;

  Entry({
    required this.key,
    required this.value,
  });
}

class HashTable {
  final _size = 10;
// Fixed array
  late final List<LinkedList<Entry>?> _list;
  HashTable() {
    _list = new List.filled(_size, null);
  }

  /// Add a new object Entry.
  void put({required int key, required String value}) {
    var index = _getIndex(key);
    var linkedListFromArr = _list.elementAt(index);

    if (linkedListFromArr != null) {
// add a new Entry to the existing linkedList at a given index in the array
      linkedListFromArr.add(Entry(key: key, value: value));
    } else {
// if no linkedList then create a new one and add it to the array at a given index
      LinkedList<Entry> newLinkedList = LinkedList<Entry>();
      newLinkedList.add(Entry(key: key, value: value));
      _list[index] = newLinkedList;
    }
  }

  /// Get an Entry object given a key
  Entry get(int key) {
    return _getEntry(key);
  }

  /// Remove an Entry object given a key
  void remove(int key) {
    var bucket = _getBucket(key);
    if (bucket == null) {
      throw Exception('No element to remove');
    }

    bucket.remove(_getEntry(key));
  }

  @override
  String toString() {
    return _list.toString();
  }

  // Private methods

  int _getIndex(key) {
    return key % _size;
  }

  LinkedList<Entry>? _getBucket(int key) {
    var index = _getIndex(key);

    if (_list.elementAt(index) == null) throw Exception("Key is not present");

    return _list[index];
  }

  Entry _getEntry(int key) {
    var bucket = _getBucket(key);

    return _getBucket(key)!.singleWhere((element) => element.key == key);
  }
}

void main() {
  HashTable roster = HashTable();
  roster.put(key: 1, value: "Mosh");
  roster.put(key: 11, value: "DuaLipa");
  roster.put(key: 12, value: "Kane");
  roster.put(key: 2, value: "Juan");
  Entry? entry_1 = roster.get(11);
  Entry? entry_2 = roster.get(1);

  print(roster);

  roster.remove(11);
  roster.remove(1);

  print(roster);
}
