// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:netflix/features/movie/domain/entities/movie_entity.dart';

class AddOrDeleteFavoriteEntity extends Equatable {
  final bool status;
  final String message;
  final MovieEntity result;

  const AddOrDeleteFavoriteEntity({
    required this.status,
    required this.message,
    required this.result,
  });

  @override
  List<Object> get props => [status, message, result];
}
