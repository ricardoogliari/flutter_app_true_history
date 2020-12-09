// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) {
  return History(
    json['title'] as String,
    json['description'] as String,
    json['city'] as String,
    json['address'] as String,
    json['site'] as String,
    json['mainSocialNetwork'] as String,
    json['otherSocialNetwork'] as String,
    json['numberTrue'] as int,
    json['numberFalse'] as int,
    (json['tags'] as List)?.map((e) => e as String)?.toList(),
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'city': instance.city,
      'address': instance.address,
      'site': instance.site,
      'mainSocialNetwork': instance.mainSocialNetwork,
      'otherSocialNetwork': instance.otherSocialNetwork,
      'numberTrue': instance.numberTrue,
      'numberFalse': instance.numberFalse,
      'tags': instance.tags,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
