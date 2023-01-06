extension StringX on String {
  T? toEnum<T extends Enum>(List<T> values) {
    try {
      return values.firstWhere((type) => type.name == this,
          orElse: () => throw Exception('Invalid enum value: $this'));
    } on Exception catch (_) {
      return null;
    }
  }
}
