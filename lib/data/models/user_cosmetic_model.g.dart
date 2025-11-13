// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cosmetic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCosmeticModel _$UserCosmeticModelFromJson(Map<String, dynamic> json) =>
    UserCosmeticModel(
      cosmeticId: json['cosmeticId'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      returnedDate: json['returnedDate'] == null
          ? null
          : DateTime.parse(json['returnedDate'] as String),
      priceAtPurchase: (json['priceAtPurchase'] as num).toDouble(),
      cosmetic: json['cosmetic'] == null
          ? null
          : CosmeticModel.fromJson(json['cosmetic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserCosmeticModelToJson(UserCosmeticModel instance) =>
    <String, dynamic>{
      'cosmeticId': instance.cosmeticId,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'returnedDate': instance.returnedDate?.toIso8601String(),
      'priceAtPurchase': instance.priceAtPurchase,
      'cosmetic': instance.cosmetic,
    };
