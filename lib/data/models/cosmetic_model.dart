import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cosmetic_model.g.dart';

@JsonSerializable()
class CosmeticModel extends Equatable {
  final String id; // GUID do banco de dados

  @JsonKey(name: 'externalId')
  final String? apiId; // ExternalId - ID original da API do Fortnite

  final String name;
  final String? description; // Nullable conforme banco de dados
  final String type;
  final String rarity;
  final double price;
  final String imageUrl;
  final bool isForSale;
  final bool isNew;

  const CosmeticModel({
    required this.id,
    this.apiId,
    required this.name,
    this.description,
    required this.type,
    required this.rarity,
    required this.price,
    required this.imageUrl,
    required this.isForSale,
    required this.isNew,
  });
  factory CosmeticModel.fromJson(Map<String, dynamic> json) =>
      _$CosmeticModelFromJson(json);

  Map<String, dynamic> toJson() => _$CosmeticModelToJson(this);

  CosmeticModel copyWith({
    String? id,
    String? apiId,
    String? name,
    String? description,
    String? type,
    String? rarity,
    double? price,
    String? imageUrl,
    bool? isForSale,
    bool? isNew,
  }) {
    return CosmeticModel(
      id: id ?? this.id,
      apiId: apiId ?? this.apiId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      rarity: rarity ?? this.rarity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isForSale: isForSale ?? this.isForSale,
      isNew: isNew ?? this.isNew,
    );
  }

  @override
  List<Object?> get props => [
    id,
    apiId,
    name,
    description,
    type,
    rarity,
    price,
    imageUrl,
    isForSale,
    isNew,
  ];
}
