// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trailer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultTrailer _$ResultTrailerFromJson(Map<String, dynamic> json) {
  return ResultTrailer(
    (json['results'] as List<dynamic>)
        .map((e) => Trailer.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResultTrailerToJson(ResultTrailer instance) =>
    <String, dynamic>{
      'results': instance.trailer,
    };

Trailer _$TrailerFromJson(Map<String, dynamic> json) {
  return Trailer(
    json['id'] as String,
    json['key'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$TrailerToJson(Trailer instance) => <String, dynamic>{
      'id': instance.trailerId,
      'key': instance.youtubeId,
      'name': instance.title,
    };
