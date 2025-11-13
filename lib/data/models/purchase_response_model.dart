import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchase_response_model.g.dart';

@JsonSerializable()
class PurchaseResponseModel extends Equatable {
  final bool success;
  final String message;
  final double? newBalance;

  const PurchaseResponseModel({
    required this.success,
    required this.message,
    this.newBalance,
  });

  factory PurchaseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PurchaseResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseResponseModelToJson(this);

  @override
  List<Object?> get props => [success, message, newBalance];
}
