// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cosmetic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CosmeticModel _$CosmeticModelFromJson(Map<String, dynamic> json) =>
    CosmeticModel(
      id: json['id'] as String,
      apiId: json['externalId'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      rarity: json['rarity'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      isForSale: json['isForSale'] as bool,
      isNew: json['isNew'] as bool,
    );

Map<String, dynamic> _$CosmeticModelToJson(CosmeticModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.apiId,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'rarity': instance.rarity,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'isForSale': instance.isForSale,
      'isNew': instance.isNew,
    };
