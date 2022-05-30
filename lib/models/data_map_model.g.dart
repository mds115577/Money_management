// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_map_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataMapModelAdapter extends TypeAdapter<DataMapModel> {
  @override
  final int typeId = 4;

  @override
  DataMapModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataMapModel(
      category: fields[1] as CategoryModel,
      all: fields[2] as TransactionModel,
      color: fields[3] as Color?,
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataMapModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.all)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataMapModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
