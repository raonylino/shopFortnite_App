import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponseModel<T> extends Equatable {
  final List<T> items;
  final int totalCount;
  final int page;
  final int pageSize;
  final int totalPages;

  const PaginatedResponseModel({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory PaginatedResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseModelToJson(this, toJsonT);

  bool get hasMore => page < totalPages;

  @override
  List<Object?> get props => [items, totalCount, page, pageSize, totalPages];
}
