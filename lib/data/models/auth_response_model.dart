import 'package:equatable/equatable.dart';
import 'package:fortnite_flutter/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel extends Equatable {
  final String token;
  final String nome;
  final String email;
  final double vbucks;
  final String userId;

  const AuthResponseModel({
    required this.token,
    required this.nome,
    required this.email,
    required this.vbucks,
    required this.userId,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  // Converter para UserModel
  UserModel toUserModel() {
    return UserModel(id: userId, nome: nome, email: email, vbucks: vbucks);
  }

  @override
  List<Object?> get props => [token, nome, email, vbucks, userId];
}
