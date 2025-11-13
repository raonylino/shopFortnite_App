import 'package:equatable/equatable.dart';
import 'package:fortnite_flutter/data/models/cosmetic_model.dart';

abstract class CosmeticsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CosmeticsInitial extends CosmeticsState {}

class CosmeticsLoading extends CosmeticsState {}

class CosmeticsLoaded extends CosmeticsState {
  final List<CosmeticModel> cosmetics;
  final int currentPage;
  final int totalPages;
  final bool hasMore;
  final bool isLoadingMore;

  CosmeticsLoaded({
    required this.cosmetics,
    required this.currentPage,
    required this.totalPages,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [
    cosmetics,
    currentPage,
    totalPages,
    hasMore,
    isLoadingMore,
  ];

  CosmeticsLoaded copyWith({
    List<CosmeticModel>? cosmetics,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return CosmeticsLoaded(
      cosmetics: cosmetics ?? this.cosmetics,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class CosmeticsError extends CosmeticsState {
  final String message;

  CosmeticsError(this.message);

  @override
  List<Object?> get props => [message];
}

class CosmeticPurchaseLoading extends CosmeticsState {}

class CosmeticPurchaseSuccess extends CosmeticsState {
  final String message;

  CosmeticPurchaseSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CosmeticPurchaseError extends CosmeticsState {
  final String message;

  CosmeticPurchaseError(this.message);

  @override
  List<Object?> get props => [message];
}
