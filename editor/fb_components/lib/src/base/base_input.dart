import 'package:fb_components/src/extension.dart/num_extension.dart';

import 'fb_enum.dart';

abstract class BaseFbInput<T> {
  final String title;
  T value;
  final FbInputType inputType;

  BaseFbInput(this.title, this.value, this.inputType);

  A cast<A extends BaseFbInput>() {
    if (this is A) {
      return this as A;
    }

    throw Exception('Unable to cast $A to type FbInputData');
  }

  dynamic get intValue {
    if (value is double) {
      return (value as double?)?.removeZeroDecimal;
    }

    return value;
  }
}

/// Group two fbInput data together so the ui can display them
/// As one widget
abstract class BaseFbGroupInput<T> extends BaseFbInput<T> {
  final FbGroupType groupType;

  BaseFbGroupInput(String title, T value, this.groupType) : super(title, value, FbInputType.group);
}
