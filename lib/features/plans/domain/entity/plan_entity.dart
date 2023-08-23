// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PlanEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String slug;
  final int price;
  final String resolution;
  final String quality;
  final List<String> supportedDevices;

  const PlanEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.slug,
    required this.price,
    required this.resolution,
    required this.quality,
    required this.supportedDevices,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        slug,
        price,
        resolution,
        quality,
        supportedDevices,
      ];
}
