// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NFTMetadata _$NFTMetadataFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'animation_url',
      'image',
      'image_ipfs',
      'description',
      'name',
      'edition',
      'drm_key',
      'drm_version',
      'drm_type'
    ],
  );
  return NFTMetadata(
    (json['media'] as List<dynamic>?)
            ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    json['animation_url'] as String,
    json['image'] as String,
    json['image_ipfs'] as String,
    json['image_data'] as String?,
    json['external_url'] as String?,
    json['description'] as String,
    json['name'] as String,
    json['edition'] as int,
    (json['attributes'] as List<dynamic>?)
        ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['background_color'] as String?,
    json['thumbnail_url'] as String?,
    json['pofo_url'] as String?,
    json['pofo_url_ipfs'] as String?,
    json['drm_key'] as String?,
    json['drm_version'] as String?,
    json['drm_type'] as String?,
  );
}

Map<String, dynamic> _$NFTMetadataToJson(NFTMetadata instance) =>
    <String, dynamic>{
      'media': instance.media?.map((e) => e.toJson()).toList(),
      'animation_url': instance.animationUrl,
      'image': instance.image,
      'image_ipfs': instance.imageIpfs,
      'image_data': instance.imageData,
      'external_url': instance.externalUrl,
      'description': instance.description,
      'name': instance.name,
      'edition': instance.edition,
      'attributes': instance.attributes?.map((e) => e.toJson()).toList(),
      'background_color': instance.backgroundColor,
      'thumbnail_url': instance.thumbnailUrl,
      'pofo_url': instance.pofoUrl,
      'pofo_url_ipfs': instance.pofoUrlIpfs,
      'drm_key': instance.drmKey,
      'drm_version': instance.drmVersion,
      'drm_type': instance.drmType,
    };
