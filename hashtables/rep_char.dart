import 'dart:collection';

String firstRepChar(String string) {
  HashMap<String, int> hash = HashMap();
  var length = string.length;
  for (var i = 0; i < length; i++) {
    if (hash.containsKey(string[i]))
      return string[i];
    else
      hash[string[i]] = 1;
  }

  return "All characters are not repeted";
}

void main() {
  String repChar = firstRepChar("A green apple");
  print(repChar);
}
