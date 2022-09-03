abstract class _Fail {
  String message;
  _Fail(this.message);
}

class Failure extends _Fail {
  Failure(String message) : super(message);
}

///Occurs whenever user tries to remove widget with multiple children
class RemoveMultipleWidgetFailure extends _Fail {
  RemoveMultipleWidgetFailure()
      : super('Cannot remove widget with multiple children');
}
