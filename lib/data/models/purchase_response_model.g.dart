// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseResponseModel _$PurchaseResponseModelFromJson(
        Map<String, dynamic> json) =>
    PurchaseResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      newBalance: (json['newBalance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PurchaseResponseModelToJson(
        PurchaseResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'newBalance': instance.newBalance,
    };
