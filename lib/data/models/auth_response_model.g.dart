// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      token: json['token'] as String,
      nome: json['nome'] as String,
      email: json['email'] as String,
      vbucks: (json['vbucks'] as num).toDouble(),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$AuthResponseModelToJson(AuthResponseModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'nome': instance.nome,
      'email': instance.email,
      'vbucks': instance.vbucks,
      'userId': instance.userId,
    };
