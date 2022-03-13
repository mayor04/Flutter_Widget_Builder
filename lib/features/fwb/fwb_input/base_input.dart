abstract class FbInputBase<T> {
  final String title;
  final T value;
  final FbInputType inputType;

  FbInputBase(this.title, this.value, this.inputType);

  A cast<A extends FbInputBase>() {
    if (this is A) {
      return this as A;
    }

    throw Exception('Unable to cast $A to type FbInputData');
  }
}

///Group two fbInput data together so the ui can display them
///As one widget
abstract class FbGroupInputBase<T> extends FbInputBase<T> {
  final FbGroupType groupType;

  FbGroupInputBase(String title, T value, this.groupType)
      : super(title, value, FbInputType.group);
}

///If the type is group we should display
///the children based on the `FbGroupType`
enum FbInputType { small, expnaded, ltrb, group }

enum FbGroupType {
  smallHW,
}
