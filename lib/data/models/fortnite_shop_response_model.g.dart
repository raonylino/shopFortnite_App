// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fortnite_shop_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FortniteShopResponseModel _$FortniteShopResponseModelFromJson(
        Map<String, dynamic> json) =>
    FortniteShopResponseModel(
      status: (json['status'] as num?)?.toInt(),
      data: ShopDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FortniteShopResponseModelToJson(
        FortniteShopResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

ShopDataModel _$ShopDataModelFromJson(Map<String, dynamic> json) =>
    ShopDataModel(
      hash: json['hash'] as String,
      date: DateTime.parse(json['date'] as String),
      vbuckIcon: json['vbuckIcon'] as String,
      entries: (json['entries'] as List<dynamic>)
          .map((e) => ShopEntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShopDataModelToJson(ShopDataModel instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'date': instance.date.toIso8601String(),
      'vbuckIcon': instance.vbuckIcon,
      'entries': instance.entries,
    };

ShopEntryModel _$ShopEntryModelFromJson(Map<String, dynamic> json) =>
    ShopEntryModel(
      regularPrice: (json['regularPrice'] as num).toInt(),
      finalPrice: (json['finalPrice'] as num).toInt(),
      devName: json['devName'] as String,
      offerId: json['offerId'] as String,
      inDate: DateTime.parse(json['inDate'] as String),
      outDate: DateTime.parse(json['outDate'] as String),
      offerTag: json['offerTag'] == null
          ? null
          : OfferTagModel.fromJson(json['offerTag'] as Map<String, dynamic>),
      bundle: json['bundle'] == null
          ? null
          : BundleModel.fromJson(json['bundle'] as Map<String, dynamic>),
      banner: json['banner'] == null
          ? null
          : BannerModel.fromJson(json['banner'] as Map<String, dynamic>),
      giftable: json['giftable'] as bool,
      refundable: json['refundable'] as bool,
      sortPriority: (json['sortPriority'] as num).toInt(),
      layoutId: json['layoutId'] as String,
      layout: json['layout'] == null
          ? null
          : LayoutModel.fromJson(json['layout'] as Map<String, dynamic>),
      colors: json['colors'] == null
          ? null
          : ColorsModel.fromJson(json['colors'] as Map<String, dynamic>),
      tileSize: json['tileSize'] as String?,
      displayAssetPath: json['displayAssetPath'] as String?,
      newDisplayAssetPath: json['newDisplayAssetPath'] as String?,
      newDisplayAsset: json['newDisplayAsset'] == null
          ? null
          : NewDisplayAssetModel.fromJson(
              json['newDisplayAsset'] as Map<String, dynamic>),
      brItems: (json['brItems'] as List<dynamic>?)
          ?.map((e) => BrItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tracks: (json['tracks'] as List<dynamic>?)
          ?.map((e) => TrackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      instruments: (json['instruments'] as List<dynamic>?)
          ?.map((e) => InstrumentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShopEntryModelToJson(ShopEntryModel instance) =>
    <String, dynamic>{
      'regularPrice': instance.regularPrice,
      'finalPrice': instance.finalPrice,
      'devName': instance.devName,
      'offerId': instance.offerId,
      'inDate': instance.inDate.toIso8601String(),
      'outDate': instance.outDate.toIso8601String(),
      'offerTag': instance.offerTag,
      'bundle': instance.bundle,
      'banner': instance.banner,
      'giftable': instance.giftable,
      'refundable': instance.refundable,
      'sortPriority': instance.sortPriority,
      'layoutId': instance.layoutId,
      'layout': instance.layout,
      'colors': instance.colors,
      'tileSize': instance.tileSize,
      'displayAssetPath': instance.displayAssetPath,
      'newDisplayAssetPath': instance.newDisplayAssetPath,
      'newDisplayAsset': instance.newDisplayAsset,
      'brItems': instance.brItems,
      'tracks': instance.tracks,
      'instruments': instance.instruments,
    };

BundleModel _$BundleModelFromJson(Map<String, dynamic> json) => BundleModel(
      name: json['name'] as String,
      info: json['info'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$BundleModelToJson(BundleModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'info': instance.info,
      'image': instance.image,
    };

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      value: json['value'] as String,
      intensity: json['intensity'] as String,
      backendValue: json['backendValue'] as String,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'intensity': instance.intensity,
      'backendValue': instance.backendValue,
    };

LayoutModel _$LayoutModelFromJson(Map<String, dynamic> json) => LayoutModel(
      id: json['id'] as String,
      name: json['name'] as String,
      index: (json['index'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      showIneligibleOffers: json['showIneligibleOffers'] as String,
      useWidePreview: json['useWidePreview'] as bool,
      displayType: json['displayType'] as String,
    );

Map<String, dynamic> _$LayoutModelToJson(LayoutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'index': instance.index,
      'rank': instance.rank,
      'showIneligibleOffers': instance.showIneligibleOffers,
      'useWidePreview': instance.useWidePreview,
      'displayType': instance.displayType,
    };

ColorsModel _$ColorsModelFromJson(Map<String, dynamic> json) => ColorsModel(
      color1: json['color1'] as String?,
      color3: json['color3'] as String?,
      textBackgroundColor: json['textBackgroundColor'] as String?,
    );

Map<String, dynamic> _$ColorsModelToJson(ColorsModel instance) =>
    <String, dynamic>{
      'color1': instance.color1,
      'color3': instance.color3,
      'textBackgroundColor': instance.textBackgroundColor,
    };

NewDisplayAssetModel _$NewDisplayAssetModelFromJson(
        Map<String, dynamic> json) =>
    NewDisplayAssetModel(
      id: json['id'] as String,
      materialInstances: json['materialInstances'] as List<dynamic>,
      renderImages: (json['renderImages'] as List<dynamic>)
          .map((e) => RenderImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewDisplayAssetModelToJson(
        NewDisplayAssetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'materialInstances': instance.materialInstances,
      'renderImages': instance.renderImages,
    };

RenderImageModel _$RenderImageModelFromJson(Map<String, dynamic> json) =>
    RenderImageModel(
      productTag: json['productTag'] as String,
      fileName: json['fileName'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$RenderImageModelToJson(RenderImageModel instance) =>
    <String, dynamic>{
      'productTag': instance.productTag,
      'fileName': instance.fileName,
      'image': instance.image,
    };

BrItemModel _$BrItemModelFromJson(Map<String, dynamic> json) => BrItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: ItemTypeModel.fromJson(json['type'] as Map<String, dynamic>),
      rarity: ItemRarityModel.fromJson(json['rarity'] as Map<String, dynamic>),
      set: json['set'] == null
          ? null
          : ItemSetModel.fromJson(json['set'] as Map<String, dynamic>),
      introduction: json['introduction'] == null
          ? null
          : IntroductionModel.fromJson(
              json['introduction'] as Map<String, dynamic>),
      images: ItemImagesModel.fromJson(json['images'] as Map<String, dynamic>),
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => VariantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaTags: (json['metaTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      showcaseVideo: json['showcaseVideo'] as String?,
      added: DateTime.parse(json['added'] as String),
    );

Map<String, dynamic> _$BrItemModelToJson(BrItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'rarity': instance.rarity,
      'set': instance.set,
      'introduction': instance.introduction,
      'images': instance.images,
      'variants': instance.variants,
      'metaTags': instance.metaTags,
      'showcaseVideo': instance.showcaseVideo,
      'added': instance.added.toIso8601String(),
    };

ItemTypeModel _$ItemTypeModelFromJson(Map<String, dynamic> json) =>
    ItemTypeModel(
      value: json['value'] as String,
      displayValue: json['displayValue'] as String,
      backendValue: json['backendValue'] as String,
    );

Map<String, dynamic> _$ItemTypeModelToJson(ItemTypeModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'displayValue': instance.displayValue,
      'backendValue': instance.backendValue,
    };

ItemRarityModel _$ItemRarityModelFromJson(Map<String, dynamic> json) =>
    ItemRarityModel(
      value: json['value'] as String,
      displayValue: json['displayValue'] as String,
      backendValue: json['backendValue'] as String,
    );

Map<String, dynamic> _$ItemRarityModelToJson(ItemRarityModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'displayValue': instance.displayValue,
      'backendValue': instance.backendValue,
    };

ItemSetModel _$ItemSetModelFromJson(Map<String, dynamic> json) => ItemSetModel(
      value: json['value'] as String,
      text: json['text'] as String,
      backendValue: json['backendValue'] as String,
    );

Map<String, dynamic> _$ItemSetModelToJson(ItemSetModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'text': instance.text,
      'backendValue': instance.backendValue,
    };

IntroductionModel _$IntroductionModelFromJson(Map<String, dynamic> json) =>
    IntroductionModel(
      chapter: json['chapter'] as String,
      season: json['season'] as String,
      text: json['text'] as String,
      backendValue: (json['backendValue'] as num).toInt(),
    );

Map<String, dynamic> _$IntroductionModelToJson(IntroductionModel instance) =>
    <String, dynamic>{
      'chapter': instance.chapter,
      'season': instance.season,
      'text': instance.text,
      'backendValue': instance.backendValue,
    };

ItemImagesModel _$ItemImagesModelFromJson(Map<String, dynamic> json) =>
    ItemImagesModel(
      smallIcon: json['smallIcon'] as String?,
      icon: json['icon'] as String?,
      featured: json['featured'] as String?,
      lego: json['lego'] == null
          ? null
          : LegoImagesModel.fromJson(json['lego'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemImagesModelToJson(ItemImagesModel instance) =>
    <String, dynamic>{
      'smallIcon': instance.smallIcon,
      'icon': instance.icon,
      'featured': instance.featured,
      'lego': instance.lego,
    };

LegoImagesModel _$LegoImagesModelFromJson(Map<String, dynamic> json) =>
    LegoImagesModel(
      small: json['small'] as String,
      large: json['large'] as String,
    );

Map<String, dynamic> _$LegoImagesModelToJson(LegoImagesModel instance) =>
    <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
    };

VariantModel _$VariantModelFromJson(Map<String, dynamic> json) => VariantModel(
      channel: json['channel'] as String?,
      type: json['type'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => VariantOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VariantModelToJson(VariantModel instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'type': instance.type,
      'options': instance.options,
    };

VariantOptionModel _$VariantOptionModelFromJson(Map<String, dynamic> json) =>
    VariantOptionModel(
      tag: json['tag'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$VariantOptionModelToJson(VariantOptionModel instance) =>
    <String, dynamic>{
      'tag': instance.tag,
      'name': instance.name,
      'image': instance.image,
    };

InstrumentModel _$InstrumentModelFromJson(Map<String, dynamic> json) =>
    InstrumentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: ItemTypeModel.fromJson(json['type'] as Map<String, dynamic>),
      rarity: ItemRarityModel.fromJson(json['rarity'] as Map<String, dynamic>),
      images: InstrumentImagesModel.fromJson(
          json['images'] as Map<String, dynamic>),
      added: DateTime.parse(json['added'] as String),
    );

Map<String, dynamic> _$InstrumentModelToJson(InstrumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'rarity': instance.rarity,
      'images': instance.images,
      'added': instance.added.toIso8601String(),
    };

InstrumentImagesModel _$InstrumentImagesModelFromJson(
        Map<String, dynamic> json) =>
    InstrumentImagesModel(
      small: json['small'] as String,
      large: json['large'] as String,
    );

Map<String, dynamic> _$InstrumentImagesModelToJson(
        InstrumentImagesModel instance) =>
    <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
    };

OfferTagModel _$OfferTagModelFromJson(Map<String, dynamic> json) =>
    OfferTagModel(
      id: json['id'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$OfferTagModelToJson(OfferTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
    };

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
      id: json['id'] as String,
      devName: json['devName'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String?,
      releaseYear: (json['releaseYear'] as num?)?.toInt(),
      bpm: (json['bpm'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      difficulty: json['difficulty'] == null
          ? null
          : TrackDifficultyModel.fromJson(
              json['difficulty'] as Map<String, dynamic>),
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      albumArt: json['albumArt'] as String,
      added: DateTime.parse(json['added'] as String),
    );

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'devName': instance.devName,
      'title': instance.title,
      'artist': instance.artist,
      'album': instance.album,
      'releaseYear': instance.releaseYear,
      'bpm': instance.bpm,
      'duration': instance.duration,
      'difficulty': instance.difficulty,
      'genres': instance.genres,
      'albumArt': instance.albumArt,
      'added': instance.added.toIso8601String(),
    };

TrackDifficultyModel _$TrackDifficultyModelFromJson(
        Map<String, dynamic> json) =>
    TrackDifficultyModel(
      vocals: (json['vocals'] as num).toInt(),
      guitar: (json['guitar'] as num).toInt(),
      bass: (json['bass'] as num).toInt(),
      plasticBass: (json['plasticBass'] as num).toInt(),
      drums: (json['drums'] as num).toInt(),
      plasticDrums: (json['plasticDrums'] as num).toInt(),
    );

Map<String, dynamic> _$TrackDifficultyModelToJson(
        TrackDifficultyModel instance) =>
    <String, dynamic>{
      'vocals': instance.vocals,
      'guitar': instance.guitar,
      'bass': instance.bass,
      'plasticBass': instance.plasticBass,
      'drums': instance.drums,
      'plasticDrums': instance.plasticDrums,
    };
