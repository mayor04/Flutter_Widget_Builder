// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_local_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileLocalEntityAdapter extends TypeAdapter<FileLocalEntity> {
  @override
  final int typeId = 0;

  @override
  FileLocalEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileLocalEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      desc: fields[2] as String,
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime,
      projectId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FileLocalEntity obj) {
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
      other is FileLocalEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
