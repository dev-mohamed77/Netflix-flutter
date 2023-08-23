// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_download_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDownloadModelAdapter extends TypeAdapter<MovieDownloadModel> {
  @override
  final int typeId = 0;

  @override
  MovieDownloadModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDownloadModel(
      title: fields[0] as String,
      image: fields[1] as String,
      streamUrl: fields[2] as String,
      movieSize: fields[3] as String,
      time: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovieDownloadModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.streamUrl)
      ..writeByte(3)
      ..write(obj.movieSize)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDownloadModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
