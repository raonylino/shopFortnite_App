import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(ignoreUnannotated: false)
class UserModel extends Equatable {
  @JsonKey(defaultValue: '')
  final String id;

  @JsonKey(name: 'name', defaultValue: '')
  final String name;

  @JsonKey(name: 'nome', defaultValue: '')
  final String nome;

  @JsonKey(defaultValue: '')
  final String email;

  @JsonKey(defaultValue: 0.0)
  final double vbucks;

  const UserModel({
    this.id = '',
    this.name = '',
    this.nome = '',
    this.email = '',
    this.vbucks = 0.0,
  });

  // Getter para obter o nome correto
  String get displayName => name.isNotEmpty ? name : nome;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? name,
    String? nome,
    String? email,
    double? vbucks,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      vbucks: vbucks ?? this.vbucks,
    );
  }

  @override
  List<Object?> get props => [id, name, nome, email, vbucks];
}
