// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:netflix/features/auth/data/model/user_model.dart';
// import 'package:netflix/features/movie/data/model/movie_model.dart';
// import 'package:netflix/features/my_list/domain/entities/favorite_entity.dart';

// class FavoritesModel extends FavoritesEntity {
//   final MovieModel movie;

//   const FavoritesModel({
//     required super.id,
//     required this.movie,
//   }) : super(movie: movie);

//   FavoritesModel copyWith({
//     String? id,
//     UserModel? user,
//     MovieModel? movie,
//   }) {
//     return FavoritesModel(
//       id: id ?? this.id,
//       movie: movie ?? this.movie,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       '_id': id,
//       'movie': movie.toMap(),
//     };
//   }

//   factory FavoritesModel.fromMap(Map<String, dynamic> map) {
//     return FavoritesModel(
//       id: map['_id'] as String,
//       movie: MovieModel.fromMap(map['movie'] as Map<String, dynamic>),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory FavoritesModel.fromJson(String source) =>
//       FavoritesModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'FavoritesModel(id: $id, movie: $movie)';

//   @override
//   bool operator ==(covariant FavoritesModel other) {
//     if (identical(this, other)) return true;

//     return other.id == id && other.movie == movie;
//   }

//   @override
//   int get hashCode => id.hashCode ^ movie.hashCode;
// }
