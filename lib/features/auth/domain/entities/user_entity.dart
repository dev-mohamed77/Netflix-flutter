// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../plans/domain/entity/plan_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String slug;
  final String gender;
  final String phone;
  final String role;
  final PlanEntity membership;
  final String membershipStartDate;
  final String membershipEndDate;
  final String passwordChangedAt;
  final String passwordResetCode;
  final int passwordResetExpires;
  final bool passwordResetVerified;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.slug,
    required this.gender,
    required this.phone,
    required this.role,
    required this.membership,
    required this.membershipStartDate,
    required this.membershipEndDate,
    required this.passwordChangedAt,
    required this.passwordResetCode,
    required this.passwordResetExpires,
    required this.passwordResetVerified,
  });
  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        password,
        slug,
        gender,
        role,
        membership,
        membershipStartDate,
        membershipEndDate,
        passwordChangedAt,
        passwordResetCode,
        passwordResetExpires,
        passwordResetVerified,
      ];
}
