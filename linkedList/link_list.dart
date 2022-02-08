class Node<T> {
  int? _index;
  Node<T>? _next;
  T value;
  Node({
    required this.value,
  });
  void setNext(Node<T>? node) {
    _next = node;
  }

  void setIndex(int index) {
    _index = index;
  }

  int? get index => _index;
  Node<T>? get next => _next;
}

abstract class Link<T> {
  void addFirst(T value);
  void addLast(T value);
  Node<T>? deleteLast();
  Node<T>? deleteFirst();
  void reverseList();
  bool contains(T value);
  List<T> toArray();
  // int indexOf(Node value);
}

class LinkList<T> extends Link<T> {
  Node<T>? first;
  Node<T>? last;

// Big O(1)
  @override
  void addFirst(T value) {
    final previous = first;

    first = Node(value: value);

    last = last ?? first;

    last!.setNext(null);

    first!.setNext(previous ?? last!);
  }

// Big O(1)
  @override
  void addLast(T value) {
    var current = Node(value: value);

    var previous = last ?? current;

    last = current;
    previous.setNext(last);
    last!.setNext(null);

    if (first == null) {
      first = last;
    }
  }

  @override
  bool contains(T value) {
    var node = first;

    while (node!.next != null) {
      if (node.value == value) return true;
      node = node.next;
    }

    return false;
  }

  @override
  Node<T>? deleteLast() {
    var current = last;
    if (last == null)
      throw Exception("There are no items to remove in the list");
    var previous = _getPrevious(last!);
    last = previous;
    last!.setNext(null);

    return current;
  }

  @override
  Node<T>? deleteFirst() {
    final previous = first;
    first = null;
    first = previous!.next;

    return previous;
  }

  @override
  List<T> toArray() {
    List<T> list = [];
    var current = first;
    while (current != null) {
      list.add(current.value);
      current = current.next;
    }
    return list;
  }

  @override
  void reverseList() {
    // LinkList<T> newList = LinkList();

    // while (first != null) {
    //   newList.addFirst(deleteFirst()!.value);
    // }

    // while (newList.first != null) {
    //   addLast(newList.deleteFirst()!.value);
    // }

    var current = first!.next;
    var prev = first;
    var lastRef = first;
    //           p    c
    // 1 -> 2 -> 3 -> 4
    // 4 -> 3 -> 2 -> 1
    while (current != null) {
      var next = current.next;
      current.setNext(prev);
      prev!.setNext(null);
      prev = current;
      current = next;
    }

    first = prev;
    last = lastRef;
    last!.setNext(null);
  }

  Node<T>? _getPrevious(Node<T> node) {
    var current = first;
    while (current != null) {
      if (current.next == last) return current;
      current = current.next;
    }

    return null;
  }
}

void main() {
  LinkList<int> list = LinkList<int>();

  list.addFirst(10);
  list.addFirst(20);
  list.addFirst(30);
  list.addLast(50);
  list.addFirst(100);
  //print(list.contais(300));
  //list.deleteLast();
  list.deleteFirst();
  print(list.toArray());

  LinkList<String> stringLink = LinkList<String>();

  stringLink.addFirst("a");
  stringLink.addFirst("b");

  print(stringLink.toArray());

  stringLink.reverseList();

  print(stringLink.toArray());
}
