String getNonRepChar(String string) {
  Map<String, int> map = {};

  for (var i = 0; i < string.length; i++) {
    if (map.containsKey(string[i])) {
      map[string[i]] = map[string[i]]! + 1;
    } else {
      map[string[i]] = 1;
    }
  }

  for (var i = 0; i < string.length; i++) {
    if (map[string[i]] == 1) return string[i];
  }

  return "All characters are repeted";
}

void main() {
  String nonRepChar = getNonRepChar("A Green Apple");

  print(nonRepChar);
}
