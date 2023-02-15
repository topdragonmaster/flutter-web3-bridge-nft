import 'package:json_annotation/json_annotation.dart';
part 'media.g.dart';

@JsonSerializable()
class CloudData {
  @JsonKey(required: true, name: 'full_media')
  String fullMedia;
  @JsonKey(required: true)
  String? thumbnail;

  CloudData(this.fullMedia, this.thumbnail);

  factory CloudData.fromJson(Map<String, dynamic> json) =>
      _$CloudDataFromJson(json);
  Map<String, dynamic> toJson() => _$CloudDataToJson(this);
}

@JsonSerializable()
class IpfsData {
  @JsonKey(required: true, name: 'full_media')
  String fullMedia;
  @JsonKey(required: false)
  String? thumbnail;
  @JsonKey(required: true)
  String ipfs;

  IpfsData(this.fullMedia, this.thumbnail, this.ipfs);

  factory IpfsData.fromJson(Map<String, dynamic> json) =>
      _$IpfsDataFromJson(json);
  Map<String, dynamic> toJson() => _$IpfsDataToJson(this);
}


@JsonSerializable(explicitToJson: true)
class Media {
  @JsonKey(required: true)
  String name;
  @JsonKey(required: true)
  String visibility;
  @JsonKey(required: true)
  bool featured;
  @JsonKey(required: false)
  int size;
  @JsonKey(required: true, name: "media_type")
  String mediaType;
  @JsonKey(required: false, name: "content_type")
  String contentType;
  @JsonKey(required: true, name: "ipfs_data")
  IpfsData ipfsData;
  @JsonKey(required: true, name: "cloud_data")
  CloudData cloudData;
  @JsonKey(required: true, name: "date_added")
  String dateAdded;
  
  Media(this.name, this.visibility, this.featured, this.size, this.mediaType, this.contentType,
      this.ipfsData, this.cloudData, this.dateAdded);

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
