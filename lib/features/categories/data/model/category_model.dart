// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:netflix/features/categories/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? slug,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'slug': slug,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['_id'] ?? "",
      name: map['name'] ?? "",
      slug: map['slug'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(id: $id, name: $name, slug: $slug)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.slug == slug;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;
}
