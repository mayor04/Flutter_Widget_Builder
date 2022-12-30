// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_local_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectLocalEntityAdapter extends TypeAdapter<ProjectLocalEntity> {
  @override
  final int typeId = 1;

  @override
  ProjectLocalEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectLocalEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      desc: fields[2] as String,
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectLocalEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectLocalEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
