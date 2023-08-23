// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'movie_download_model.g.dart';

@HiveType(typeId: 0)
class MovieDownloadModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final String streamUrl;
  @HiveField(3)
  final String movieSize;
  @HiveField(4)
  final String time;

  MovieDownloadModel({
    required this.title,
    required this.image,
    required this.streamUrl,
    required this.movieSize,
    required this.time,
  });
}
