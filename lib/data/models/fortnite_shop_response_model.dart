import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fortnite_shop_response_model.g.dart';

@JsonSerializable()
class FortniteShopResponseModel extends Equatable {
  final int? status;
  final ShopDataModel data;

  const FortniteShopResponseModel({this.status, required this.data});

  factory FortniteShopResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FortniteShopResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FortniteShopResponseModelToJson(this);

  @override
  List<Object?> get props => [status, data];
}

@JsonSerializable()
class ShopDataModel extends Equatable {
  final String hash;
  final DateTime date;
  final String vbuckIcon;
  final List<ShopEntryModel> entries;

  const ShopDataModel({
    required this.hash,
    required this.date,
    required this.vbuckIcon,
    required this.entries,
  });

  factory ShopDataModel.fromJson(Map<String, dynamic> json) =>
      _$ShopDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopDataModelToJson(this);

  @override
  List<Object?> get props => [hash, date, vbuckIcon, entries];
}

@JsonSerializable()
class ShopEntryModel extends Equatable {
  final int regularPrice;
  final int finalPrice;
  final String devName;
  final String offerId;
  final DateTime inDate;
  final DateTime outDate;
  final OfferTagModel? offerTag;
  final BundleModel? bundle;
  final BannerModel? banner;
  final bool giftable;
  final bool refundable;
  final int sortPriority;
  final String layoutId;
  final LayoutModel? layout;
  final ColorsModel? colors;
  final String? tileSize;
  final String? displayAssetPath;
  final String? newDisplayAssetPath;
  final NewDisplayAssetModel? newDisplayAsset;
  final List<BrItemModel>? brItems;
  final List<TrackModel>? tracks;
  final List<InstrumentModel>? instruments;

  const ShopEntryModel({
    required this.regularPrice,
    required this.finalPrice,
    required this.devName,
    required this.offerId,
    required this.inDate,
    required this.outDate,
    this.offerTag,
    this.bundle,
    this.banner,
    required this.giftable,
    required this.refundable,
    required this.sortPriority,
    required this.layoutId,
    this.layout,
    this.colors,
    this.tileSize,
    this.displayAssetPath,
    this.newDisplayAssetPath,
    this.newDisplayAsset,
    this.brItems,
    this.tracks,
    this.instruments,
  });

  factory ShopEntryModel.fromJson(Map<String, dynamic> json) =>
      _$ShopEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopEntryModelToJson(this);

  @override
  List<Object?> get props => [
    regularPrice,
    finalPrice,
    devName,
    offerId,
    inDate,
    outDate,
    offerTag,
    bundle,
    banner,
    giftable,
    refundable,
    sortPriority,
    layoutId,
    layout,
    colors,
    tileSize,
    displayAssetPath,
    newDisplayAssetPath,
    newDisplayAsset,
    brItems,
    tracks,
    instruments,
  ];
}

@JsonSerializable()
class BundleModel extends Equatable {
  final String name;
  final String info;
  final String image;

  const BundleModel({
    required this.name,
    required this.info,
    required this.image,
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) =>
      _$BundleModelFromJson(json);

  Map<String, dynamic> toJson() => _$BundleModelToJson(this);

  @override
  List<Object?> get props => [name, info, image];
}

@JsonSerializable()
class BannerModel extends Equatable {
  final String value;
  final String intensity;
  final String backendValue;

  const BannerModel({
    required this.value,
    required this.intensity,
    required this.backendValue,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

  @override
  List<Object?> get props => [value, intensity, backendValue];
}

@JsonSerializable()
class LayoutModel extends Equatable {
  final String id;
  final String name;
  final int index;
  final int rank;
  final String showIneligibleOffers;
  final bool useWidePreview;
  final String displayType;

  const LayoutModel({
    required this.id,
    required this.name,
    required this.index,
    required this.rank,
    required this.showIneligibleOffers,
    required this.useWidePreview,
    required this.displayType,
  });

  factory LayoutModel.fromJson(Map<String, dynamic> json) =>
      _$LayoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$LayoutModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    index,
    rank,
    showIneligibleOffers,
    useWidePreview,
    displayType,
  ];
}

@JsonSerializable()
class ColorsModel extends Equatable {
  final String? color1;
  final String? color3;
  final String? textBackgroundColor;

  const ColorsModel({this.color1, this.color3, this.textBackgroundColor});

  factory ColorsModel.fromJson(Map<String, dynamic> json) =>
      _$ColorsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ColorsModelToJson(this);

  @override
  List<Object?> get props => [color1, color3, textBackgroundColor];
}

@JsonSerializable()
class NewDisplayAssetModel extends Equatable {
  final String id;
  final List<dynamic> materialInstances;
  final List<RenderImageModel> renderImages;

  const NewDisplayAssetModel({
    required this.id,
    required this.materialInstances,
    required this.renderImages,
  });

  factory NewDisplayAssetModel.fromJson(Map<String, dynamic> json) =>
      _$NewDisplayAssetModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewDisplayAssetModelToJson(this);

  @override
  List<Object?> get props => [id, materialInstances, renderImages];
}

@JsonSerializable()
class RenderImageModel extends Equatable {
  final String productTag;
  final String fileName;
  final String image;

  const RenderImageModel({
    required this.productTag,
    required this.fileName,
    required this.image,
  });

  factory RenderImageModel.fromJson(Map<String, dynamic> json) =>
      _$RenderImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$RenderImageModelToJson(this);

  @override
  List<Object?> get props => [productTag, fileName, image];
}

@JsonSerializable()
class BrItemModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final ItemTypeModel type;
  final ItemRarityModel rarity;
  final ItemSetModel? set;
  final IntroductionModel? introduction;
  final ItemImagesModel images;
  final List<VariantModel>? variants;
  final List<String>? metaTags;
  final String? showcaseVideo;
  final DateTime added;

  const BrItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.rarity,
    this.set,
    this.introduction,
    required this.images,
    this.variants,
    this.metaTags,
    this.showcaseVideo,
    required this.added,
  });

  factory BrItemModel.fromJson(Map<String, dynamic> json) =>
      _$BrItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrItemModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    type,
    rarity,
    set,
    introduction,
    images,
    variants,
    metaTags,
    showcaseVideo,
    added,
  ];
}

@JsonSerializable()
class ItemTypeModel extends Equatable {
  final String value;
  final String displayValue;
  final String backendValue;

  const ItemTypeModel({
    required this.value,
    required this.displayValue,
    required this.backendValue,
  });

  factory ItemTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ItemTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemTypeModelToJson(this);

  @override
  List<Object?> get props => [value, displayValue, backendValue];
}

@JsonSerializable()
class ItemRarityModel extends Equatable {
  final String value;
  final String displayValue;
  final String backendValue;

  const ItemRarityModel({
    required this.value,
    required this.displayValue,
    required this.backendValue,
  });

  factory ItemRarityModel.fromJson(Map<String, dynamic> json) =>
      _$ItemRarityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemRarityModelToJson(this);

  @override
  List<Object?> get props => [value, displayValue, backendValue];
}

@JsonSerializable()
class ItemSetModel extends Equatable {
  final String value;
  final String text;
  final String backendValue;

  const ItemSetModel({
    required this.value,
    required this.text,
    required this.backendValue,
  });

  factory ItemSetModel.fromJson(Map<String, dynamic> json) =>
      _$ItemSetModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSetModelToJson(this);

  @override
  List<Object?> get props => [value, text, backendValue];
}

@JsonSerializable()
class IntroductionModel extends Equatable {
  final String chapter;
  final String season;
  final String text;
  final int backendValue;

  const IntroductionModel({
    required this.chapter,
    required this.season,
    required this.text,
    required this.backendValue,
  });

  factory IntroductionModel.fromJson(Map<String, dynamic> json) =>
      _$IntroductionModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntroductionModelToJson(this);

  @override
  List<Object?> get props => [chapter, season, text, backendValue];
}

@JsonSerializable()
class ItemImagesModel extends Equatable {
  final String? smallIcon;
  final String? icon;
  final String? featured;
  final LegoImagesModel? lego;

  const ItemImagesModel({this.smallIcon, this.icon, this.featured, this.lego});

  factory ItemImagesModel.fromJson(Map<String, dynamic> json) =>
      _$ItemImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemImagesModelToJson(this);

  @override
  List<Object?> get props => [smallIcon, icon, featured, lego];
}

@JsonSerializable()
class LegoImagesModel extends Equatable {
  final String small;
  final String large;

  const LegoImagesModel({required this.small, required this.large});

  factory LegoImagesModel.fromJson(Map<String, dynamic> json) =>
      _$LegoImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$LegoImagesModelToJson(this);

  @override
  List<Object?> get props => [small, large];
}

@JsonSerializable()
class VariantModel extends Equatable {
  final String? channel;
  final String? type;
  final List<VariantOptionModel>? options;

  const VariantModel({this.channel, this.type, this.options});

  factory VariantModel.fromJson(Map<String, dynamic> json) =>
      _$VariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantModelToJson(this);

  @override
  List<Object?> get props => [channel, type, options];
}

@JsonSerializable()
class VariantOptionModel extends Equatable {
  final String tag;
  final String name;
  final String image;

  const VariantOptionModel({
    required this.tag,
    required this.name,
    required this.image,
  });

  factory VariantOptionModel.fromJson(Map<String, dynamic> json) =>
      _$VariantOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantOptionModelToJson(this);

  @override
  List<Object?> get props => [tag, name, image];
}

@JsonSerializable()
class InstrumentModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final ItemTypeModel type;
  final ItemRarityModel rarity;
  final InstrumentImagesModel images;
  final DateTime added;

  const InstrumentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.rarity,
    required this.images,
    required this.added,
  });

  factory InstrumentModel.fromJson(Map<String, dynamic> json) =>
      _$InstrumentModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstrumentModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    type,
    rarity,
    images,
    added,
  ];
}

@JsonSerializable()
class InstrumentImagesModel extends Equatable {
  final String small;
  final String large;

  const InstrumentImagesModel({required this.small, required this.large});

  factory InstrumentImagesModel.fromJson(Map<String, dynamic> json) =>
      _$InstrumentImagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstrumentImagesModelToJson(this);

  @override
  List<Object?> get props => [small, large];
}

@JsonSerializable()
class OfferTagModel extends Equatable {
  final String id;
  final String text;

  const OfferTagModel({required this.id, required this.text});

  factory OfferTagModel.fromJson(Map<String, dynamic> json) =>
      _$OfferTagModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferTagModelToJson(this);

  @override
  List<Object?> get props => [id, text];
}

@JsonSerializable()
class TrackModel extends Equatable {
  final String id;
  final String devName;
  final String title;
  final String artist;
  final String? album;
  final int? releaseYear;
  final int? bpm;
  final int? duration;
  final TrackDifficultyModel? difficulty;
  final List<String>? genres;
  final String albumArt;
  final DateTime added;

  const TrackModel({
    required this.id,
    required this.devName,
    required this.title,
    required this.artist,
    this.album,
    this.releaseYear,
    this.bpm,
    this.duration,
    this.difficulty,
    this.genres,
    required this.albumArt,
    required this.added,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) =>
      _$TrackModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrackModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    devName,
    title,
    artist,
    album,
    releaseYear,
    bpm,
    duration,
    difficulty,
    genres,
    albumArt,
    added,
  ];
}

@JsonSerializable()
class TrackDifficultyModel extends Equatable {
  final int vocals;
  final int guitar;
  final int bass;
  final int plasticBass;
  final int drums;
  final int plasticDrums;

  const TrackDifficultyModel({
    required this.vocals,
    required this.guitar,
    required this.bass,
    required this.plasticBass,
    required this.drums,
    required this.plasticDrums,
  });

  factory TrackDifficultyModel.fromJson(Map<String, dynamic> json) =>
      _$TrackDifficultyModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrackDifficultyModelToJson(this);

  @override
  List<Object?> get props => [
    vocals,
    guitar,
    bass,
    plasticBass,
    drums,
    plasticDrums,
  ];
}
