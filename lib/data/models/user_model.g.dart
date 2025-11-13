// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      nome: json['nome'] as String? ?? '',
      email: json['email'] as String? ?? '',
      vbucks: (json['vbucks'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nome': instance.nome,
      'email': instance.email,
      'vbucks': instance.vbucks,
    };
