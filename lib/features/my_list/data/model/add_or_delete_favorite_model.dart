// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:netflix/features/movie/data/model/movie_model.dart';
import 'package:netflix/features/my_list/domain/entities/add_or_delete_favorite_entity.dart';

class AddOrDeleteFavoriteModel extends AddOrDeleteFavoriteEntity {
  final MovieModel result;

  const AddOrDeleteFavoriteModel({
    required super.status,
    required super.message,
    required this.result,
  }) : super(result: result);

  AddOrDeleteFavoriteModel copyWith({
    bool? status,
    String? message,
    MovieModel? result,
  }) {
    return AddOrDeleteFavoriteModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'result': result.toMap(),
    };
  }

  factory AddOrDeleteFavoriteModel.fromMap(Map<String, dynamic> map) {
    return AddOrDeleteFavoriteModel(
      status: map['status'] as bool,
      message: map['message'] as String,
      result: MovieModel.fromMap(map['result'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddOrDeleteFavoriteModel.fromJson(String source) =>
      AddOrDeleteFavoriteModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AddOrDeleteFavoriteModel(status: $status, message: $message, result: $result)';

  @override
  bool operator ==(covariant AddOrDeleteFavoriteModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        other.result == result;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ result.hashCode;
}
