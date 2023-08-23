// ignore_for_file: public_member_api_docs, sort_constructors_first, overridden_fields, annotate_overrides
import 'dart:convert';

import 'package:netflix/features/auth/data/model/user_model.dart';
import 'package:netflix/features/auth/domain/entities/signin_entity.dart';

class SignInModel extends SignInEntity {
  final UserModel user;
  final String token;
  const SignInModel({
    required this.user,
    required this.token,
  }) : super(user: user, token: token);

  SignInModel copyWith({
    UserModel? user,
    String? token,
  }) {
    return SignInModel(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'token': token,
    };
  }

  factory SignInModel.fromMap(Map<String, dynamic> map) {
    return SignInModel(
      user: UserModel.fromMap(map['user'] ?? {}),
      token: map['token'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInModel.fromJson(String source) =>
      SignInModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SignInModel(user: $user, token: $token)';

  @override
  bool operator ==(covariant SignInModel other) {
    if (identical(this, other)) return true;

    return other.user == user && other.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}
