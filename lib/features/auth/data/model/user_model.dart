// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:netflix/features/auth/domain/entities/user_entity.dart';
import 'package:netflix/features/plans/data/models/plan_model.dart';

class UserModel extends UserEntity {
  final PlanModel membership;
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.password,
    required super.slug,
    required super.gender,
    required super.phone,
    required super.role,
    required this.membership,
    required super.membershipStartDate,
    required super.membershipEndDate,
    required super.passwordChangedAt,
    required super.passwordResetCode,
    required super.passwordResetExpires,
    required super.passwordResetVerified,
  }) : super(membership: membership);
  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
    String? slug,
    String? gender,
    String? phone,
    String? role,
    PlanModel? membership,
    String? membershipStartDate,
    String? membershipEndDate,
    String? passwordChangedAt,
    String? passwordResetCode,
    int? passwordResetExpires,
    bool? passwordResetVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      slug: slug ?? this.slug,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      membership: membership ?? this.membership,
      membershipStartDate: membershipStartDate ?? this.membershipStartDate,
      membershipEndDate: membershipEndDate ?? this.membershipEndDate,
      passwordChangedAt: passwordChangedAt ?? this.passwordChangedAt,
      passwordResetCode: passwordResetCode ?? this.passwordResetCode,
      passwordResetExpires: passwordResetExpires ?? this.passwordResetExpires,
      passwordResetVerified:
          passwordResetVerified ?? this.passwordResetVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'slug': slug,
      'gender': gender,
      'phone': phone,
      'role': role,
      'membership': membership.toMap(),
      'membershipStartDate': membershipStartDate,
      'membershipEndDate': membershipEndDate,
      'passwordChangedAt': passwordChangedAt,
      'passwordResetCode': passwordResetCode,
      'passwordResetExpires': passwordResetExpires,
      'passwordResetVerified': passwordResetVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? "",
      fullName: map['fullName'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      slug: map['slug'] ?? "",
      gender: map['gender'] ?? "",
      phone: map['phone'] ?? "",
      role: map['role'] ?? "",
      membership: PlanModel.fromMap(map['membership'] ?? {}),
      membershipStartDate: map['membershipStartDate'] ?? "",
      membershipEndDate: map['membershipEndDate'] ?? "",
      passwordChangedAt: map['passwordChangedAt'] ?? "",
      passwordResetCode: map['passwordResetCode'] ?? "",
      passwordResetExpires: map['passwordResetExpires'] ?? 0,
      passwordResetVerified: map['passwordResetVerified'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, email: $email, password: $password, phone: $phone, slug: $slug, gender: $gender, role: $role, membership: $membership, membershipStartDate: $membershipStartDate, membershipEndDate: $membershipEndDate, passwordChangedAt: $passwordChangedAt, passwordResetCode: $passwordResetCode, passwordResetExpires: $passwordResetExpires, passwordResetVerified: $passwordResetVerified)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.email == email &&
        other.password == password &&
        other.slug == slug &&
        other.gender == gender &&
        other.phone == phone &&
        other.role == role &&
        other.membership == membership &&
        other.membershipStartDate == membershipStartDate &&
        other.membershipEndDate == membershipEndDate &&
        other.passwordChangedAt == passwordChangedAt &&
        other.passwordResetCode == passwordResetCode &&
        other.passwordResetExpires == passwordResetExpires &&
        other.passwordResetVerified == passwordResetVerified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        slug.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        role.hashCode ^
        membership.hashCode ^
        membershipStartDate.hashCode ^
        membershipEndDate.hashCode ^
        passwordChangedAt.hashCode ^
        passwordResetCode.hashCode ^
        passwordResetExpires.hashCode ^
        passwordResetVerified.hashCode;
  }
}
