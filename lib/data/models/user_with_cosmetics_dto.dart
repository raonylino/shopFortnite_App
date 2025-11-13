import 'package:equatable/equatable.dart';
import 'package:fortnite_flutter/data/models/cosmetic_model.dart';
import 'package:fortnite_flutter/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_with_cosmetics_dto.g.dart';

@JsonSerializable()
class UserWithCosmeticsDto extends Equatable {
  final UserModel user;
  final List<CosmeticModel> cosmetics;

  const UserWithCosmeticsDto({required this.user, required this.cosmetics});

  factory UserWithCosmeticsDto.fromJson(Map<String, dynamic> json) {
    // Verifica se tem o objeto 'user' separado ou se os dados do usuário estão no root
    final bool hasUserObject = json.containsKey('user');

    final UserModel user;
    if (hasUserObject) {
      // Formato: { "user": {...}, "cosmetics": [...] }
      user = UserModel.fromJson(json['user'] as Map<String, dynamic>);
    } else {
      // Formato: { "id": "...", "email": "...", "cosmetics": [...] }
      // Extrai apenas os campos do usuário
      user = UserModel.fromJson({
        'id': json['id'],
        'email': json['email'],
        'vbucks': json['vbucks'],
        'name': json['name'],
        'nome': json['nome'],
      });
    }

    // Extrai os cosméticos
    final List<dynamic> cosmeticsJson =
        json['cosmetics'] as List<dynamic>? ?? [];

    // Verifica se são UserCosmeticModel (com purchaseDate) ou CosmeticModel diretos
    final List<CosmeticModel> cosmetics = cosmeticsJson.map((e) {
      final Map<String, dynamic> item = e as Map<String, dynamic>;
      // Se tem 'cosmetic' dentro, é UserCosmeticModel
      if (item.containsKey('cosmetic')) {
        return CosmeticModel.fromJson(item['cosmetic'] as Map<String, dynamic>);
      }
      // Senão, é CosmeticModel direto
      return CosmeticModel.fromJson(item);
    }).toList();

    return UserWithCosmeticsDto(user: user, cosmetics: cosmetics);
  }

  Map<String, dynamic> toJson() => _$UserWithCosmeticsDtoToJson(this);

  @override
  List<Object?> get props => [user, cosmetics];
}
