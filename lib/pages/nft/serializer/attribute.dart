import 'package:json_annotation/json_annotation.dart';
part 'attribute.g.dart';

@JsonSerializable()
class Attribute {
  @JsonKey(required: true, name: 'trait_type')
  String traitType;
  @JsonKey(required: true)
  String value;
  @JsonKey(required: true)
  String key;

  Attribute(this.traitType, this.value, this.key);

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}
