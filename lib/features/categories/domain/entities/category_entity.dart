// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String slug;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
  });

  @override
  List<Object> get props => [id, name, slug];
}
