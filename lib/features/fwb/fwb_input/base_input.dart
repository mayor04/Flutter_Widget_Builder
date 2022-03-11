abstract class FbInput<T> {
  final String title;
  final T value;
  final FbInputType fbInputType;

  FbInput(this.title, this.value, this.fbInputType);
}

abstract class FbGroupInput<T> extends FbInput<T> {
  final FbGroupType fbGroupType;

  FbGroupInput(String title, T value, this.fbGroupType)
      : super(title, value, FbInputType.group);
}

enum FbInputType { small, expnaded, ltrb, group }

enum FbGroupType {
  small2,
}
