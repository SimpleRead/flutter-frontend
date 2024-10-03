// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Work _$WorkFromJson(Map<String, dynamic> json) => Work(
      title: json['title'] as String,
      author: json['author'] as String,
      uri: json['uri'] as String,
      synopsis: json['synopsis'] as String,
    );

Map<String, dynamic> _$WorkToJson(Work instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'uri': instance.uri,
      'synopsis': instance.synopsis,
    };

Slide _$SlideFromJson(Map<String, dynamic> json) => Slide(
      text: json['text'] as String,
      imageUri: json['image'] as String,
      audioUri: json['audio'] as String,
    );

Map<String, dynamic> _$SlideToJson(Slide instance) => <String, dynamic>{
      'text': instance.text,
      'image': instance.imageUri,
      'audio': instance.audioUri,
    };

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      work: Work.fromJson(json['work'] as Map<String, dynamic>),
      thumbnailUri: json['thumbnail'] as String,
      guid: json['guid'] as String,
      length: (json['num_slides'] as num).toInt(),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'work': instance.work,
      'thumbnail': instance.thumbnailUri,
      'guid': instance.guid,
      'num_slides': instance.length,
    };

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
      book: Book.fromJson(json['book'] as Map<String, dynamic>),
      progress: (json['progress'] as num).toInt(),
      guid: json['guid'] as String,
    );

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'book': instance.book,
      'progress': instance.progress,
      'guid': instance.guid,
    };

Homepage _$HomepageFromJson(Map<String, dynamic> json) => Homepage(
      currentlyReading: (json['current'] as List<dynamic>)
          .map((e) => Experience.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommended: (json['recommend'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomepageToJson(Homepage instance) => <String, dynamic>{
      'current': instance.currentlyReading,
      'recommend': instance.recommended,
    };
