// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../domain/entity/plan_entity.dart';

class PlanModel extends PlanEntity {
  const PlanModel({
    required super.id,
    required super.title,
    required super.description,
    required super.slug,
    required super.price,
    required super.resolution,
    required super.quality,
    required super.supportedDevices,
  });

  PlanModel copyWith({
    String? id,
    String? title,
    String? description,
    String? slug,
    int? price,
    String? resolution,
    String? quality,
    List<String>? supportedDevices,
  }) {
    return PlanModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      slug: slug ?? this.slug,
      price: price ?? this.price,
      resolution: resolution ?? this.resolution,
      quality: quality ?? this.quality,
      supportedDevices: supportedDevices ?? this.supportedDevices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "_id": id,
      'title': title,
      'description': description,
      'slug': slug,
      'price': price,
      'resolution': resolution,
      'quality': quality,
      'supportedDevices': supportedDevices,
    };
  }

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
        id: map["_id"] ?? "",
        title: map['title'] ?? "",
        description: map['description'] ?? "",
        slug: map['slug'] ?? "",
        price: map['price'] ?? 0,
        resolution: map['resolution'] ?? "",
        quality: map['quality'] ?? "",
        supportedDevices: List<String>.from(
          (map['supportedDevices'] ?? []),
        ));
  }

  String toJson() => json.encode(toMap());

  factory PlanModel.fromJson(String source) =>
      PlanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlanModel(id: $id, title: $title, description: $description, slug: $slug, price: $price, resolution: $resolution, quality: $quality, supportedDevices: $supportedDevices)';
  }

  @override
  bool operator ==(covariant PlanModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.slug == slug &&
        other.price == price &&
        other.resolution == resolution &&
        other.quality == quality &&
        listEquals(other.supportedDevices, supportedDevices);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        slug.hashCode ^
        price.hashCode ^
        resolution.hashCode ^
        quality.hashCode ^
        supportedDevices.hashCode;
  }
}
