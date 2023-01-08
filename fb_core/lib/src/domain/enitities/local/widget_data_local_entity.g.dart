// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_data_local_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WidgetDataLocalEntityAdapter extends TypeAdapter<WidgetDataLocalEntity> {
  @override
  final int typeId = 2;

  @override
  WidgetDataLocalEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WidgetDataLocalEntity(
      id: fields[0] as String,
      idList: (fields[1] as List).cast<String>(),
      fbConfigMap: (fields[2] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as Map).cast<String, dynamic>())),
      fbDetailsMap: (fields[3] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as Map).cast<String, dynamic>())),
    );
  }

  @override
  void write(BinaryWriter writer, WidgetDataLocalEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idList)
      ..writeByte(2)
      ..write(obj.fbConfigMap)
      ..writeByte(3)
      ..write(obj.fbDetailsMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WidgetDataLocalEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
