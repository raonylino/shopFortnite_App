// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'cosmeticId': instance.cosmeticId,
      'type': instance.type,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'cosmeticName': instance.cosmeticName,
      'cosmeticImageUrl': instance.cosmeticImageUrl,
      'cosmeticRarity': instance.cosmeticRarity,
    };
