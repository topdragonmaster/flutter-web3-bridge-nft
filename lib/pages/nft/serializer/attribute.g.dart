// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attribute _$AttributeFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['trait_type', 'value', 'key'],
  );
  return Attribute(
    json['trait_type'] as String,
    json['value'] as String,
    json['key'] as String,
  );
}

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
      'trait_type': instance.traitType,
      'value': instance.value,
      'key': instance.key,
    };
