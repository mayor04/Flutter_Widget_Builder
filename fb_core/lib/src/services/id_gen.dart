class IdGen {
  static int generateIdInt() => DateTime.now().microsecondsSinceEpoch;
  static String generateIdString() => DateTime.now().microsecondsSinceEpoch.toString();
}
