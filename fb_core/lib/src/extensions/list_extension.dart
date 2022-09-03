extension SafeListX<T> on List<T> {
  ///Returns null when the element at the index
  ///is not present
  T? itemAt(int index) {
    if (index >= length) {
      return null;
    }
    return this[index];
  }
}
