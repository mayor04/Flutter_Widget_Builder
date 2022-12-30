// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files_local_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilesLocalEntityAdapter extends TypeAdapter<FilesLocalEntity> {
  @override
  final int typeId = 0;

  @override
  FilesLocalEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilesLocalEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      desc: fields[2] as String,
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime,
      projectId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FilesLocalEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(3)
      ..write(obj.projectId)
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
      other is FilesLocalEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
