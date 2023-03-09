/// In order to use the general parameters which can be dynamic, we
/// need to store the reference to the params and also the name of the style that uses it
/// This solves the issue of updating the params everywhere it is being used
///
/// This method also helps when a custom widget is reused in another widget
class StyleParams {
  final String paramId;
  final String styleName;

  StyleParams({
    required this.paramId,
    required this.styleName,
  });

  factory StyleParams.fromJson(Map<String, dynamic> json) {
    return StyleParams(
      paramId: json['paramId'],
      styleName: json['styleName'],
    );
  }

  // Each params should provide a way to parse its valus
  value() {}

  // to json
  Map<String, dynamic> toJson() => {
        'paramId': paramId,
        'styleName': styleName,
      };

  // from json

}
