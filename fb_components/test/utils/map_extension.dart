import 'dart:convert';

extension MapX on Map<String, dynamic> {
  // This is a to effectively deep copy a map
  reDecode() => jsonDecode(jsonEncode(this));
}
