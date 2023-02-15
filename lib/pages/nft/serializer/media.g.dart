// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloudData _$CloudDataFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['full_media', 'thumbnail'],
  );
  return CloudData(
    json['full_media'] as String,
    json['thumbnail'] as String?,
  );
}

Map<String, dynamic> _$CloudDataToJson(CloudData instance) => <String, dynamic>{
      'full_media': instance.fullMedia,
      'thumbnail': instance.thumbnail,
    };

IpfsData _$IpfsDataFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['full_media', 'ipfs'],
  );
  return IpfsData(
    json['full_media'] as String,
    json['thumbnail'] as String?,
    json['ipfs'] as String,
  );
}

Map<String, dynamic> _$IpfsDataToJson(IpfsData instance) => <String, dynamic>{
      'full_media': instance.fullMedia,
      'thumbnail': instance.thumbnail,
      'ipfs': instance.ipfs,
    };

Media _$MediaFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'name',
      'visibility',
      'featured',
      'media_type',
      'ipfs_data',
      'cloud_data',
      'date_added'
    ],
  );
  return Media(
    json['name'] as String,
    json['visibility'] as String,
    json['featured'] as bool,
    json['size'] as int,
    json['media_type'] as String,
    json['content_type'] as String,
    IpfsData.fromJson(json['ipfs_data'] as Map<String, dynamic>),
    CloudData.fromJson(json['cloud_data'] as Map<String, dynamic>),
    json['date_added'] as String,
  );
}

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'name': instance.name,
      'visibility': instance.visibility,
      'featured': instance.featured,
      'size': instance.size,
      'media_type': instance.mediaType,
      'content_type': instance.contentType,
      'ipfs_data': instance.ipfsData.toJson(),
      'cloud_data': instance.cloudData.toJson(),
      'date_added': instance.dateAdded,
    };
