extension DoubleX on double {
  num get removeZeroDecimal {
    if ((this % 1) == 0) {
      return toInt();
    }

    return this;
  }
}
