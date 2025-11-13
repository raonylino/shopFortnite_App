import 'package:equatable/equatable.dart';
import 'package:fortnite_flutter/data/models/cosmetic_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_cosmetic_model.g.dart';

@JsonSerializable()
class UserCosmeticModel extends Equatable {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? userId; // GUID - opcional pois não vem da API

  final String cosmeticId; // GUID

  // A API retorna 'purchasedAt', mas vamos ler de 'purchaseDate' também se houver
  final DateTime purchaseDate;

  final DateTime? returnedDate;
  final double priceAtPurchase;

  // Campo opcional para incluir detalhes do cosmético
  final CosmeticModel? cosmetic;

  const UserCosmeticModel({
    this.userId,
    required this.cosmeticId,
    required this.purchaseDate,
    this.returnedDate,
    required this.priceAtPurchase,
    this.cosmetic,
  });

  factory UserCosmeticModel.fromJson(Map<String, dynamic> json) =>
      _$UserCosmeticModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCosmeticModelToJson(this);

  // Helper para verificar se o cosmético está ativo (não devolvido)
  bool get isActive => returnedDate == null;

  @override
  List<Object?> get props => [
    userId,
    cosmeticId,
    purchaseDate,
    returnedDate,
    priceAtPurchase,
    cosmetic,
  ];
}
