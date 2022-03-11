import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_builder/features/fwb/fwb_input/base_input.dart';

class FbInputSmall<T> extends FbInput<T> {
  FbInputSmall(String title, T value) : super(title, value, FbInputType.small);
}

class FbInputExpanded<T extends Comparable?> extends FbInput<T> {
  FbInputExpanded(String title, T value)
      : super(title, value, FbInputType.expnaded);
}

class FbInputLTRB<T extends List?> extends FbInput<T> {
  FbInputLTRB(String title, T value) : super(title, value, FbInputType.ltrb);
}
