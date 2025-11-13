import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends Equatable {
  final String id; // GUID
  final String userId; // GUID
  final String cosmeticId; // GUID

  @JsonKey(defaultValue: '')
  final String type; // 'Purchase' ou 'Return' - pode ser vazio se não vier da API

  final double amount;
  final DateTime date;

  // Campos opcionais para informações detalhadas
  final String? cosmeticName;
  final String? cosmeticImageUrl;
  final String? cosmeticRarity;

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.cosmeticId,
    this.type = '',
    required this.amount,
    required this.date,
    this.cosmeticName,
    this.cosmeticImageUrl,
    this.cosmeticRarity,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    // Helper para converter int ou String para String
    String parseValue(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      if (value is int) return value.toString();
      return value.toString();
    }

    // Converter o tipo de número para string se necessário
    String parseType(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      if (value is int) {
        // 0 = Purchase, 1 = Return (exemplo comum de enum no backend)
        if (value == 0) return 'Purchase';
        if (value == 1) return 'Return';
        return value.toString();
      }
      return value.toString();
    }

    final parsedType = parseType(json['type']);

    return TransactionModel(
      id: parseValue(json['id']),
      userId: parseValue(json['userId']),
      cosmeticId: parseValue(json['cosmeticId']),
      type: parsedType,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      cosmeticName: json['cosmeticName'] as String?,
      cosmeticImageUrl: json['cosmeticImageUrl'] as String?,
      cosmeticRarity: json['cosmeticRarity'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  bool get isPurchase => type.toLowerCase() == 'purchase';
  bool get isReturn => type.toLowerCase() == 'return';

  @override
  List<Object?> get props => [
    id,
    userId,
    cosmeticId,
    type,
    amount,
    date,
    cosmeticName,
    cosmeticImageUrl,
    cosmeticRarity,
  ];
}
