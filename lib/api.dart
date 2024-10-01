import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api.g.dart';

@JsonSerializable()
class Work {
  String title;
  String author;
  String uri;

  Work({required this.title, required this.author, required this.uri});

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);
  Map<String, dynamic> toJson() => _$WorkToJson(this);
}

@JsonSerializable()
class Slide {
  String text;

  @JsonKey(name: "image")
  String imageUri;

  @JsonKey(name: "audio")
  String audioUri;

  Image get thumbnail => Image.network(imageUri);
  // TODO: Some audio thing as well

  Slide({required this.text, required this.imageUri, required this.audioUri});

  factory Slide.fromJson(Map<String, dynamic> json) => _$SlideFromJson(json);
  Map<String, dynamic> toJson() => _$SlideToJson(this);
}

@JsonSerializable()
class Book {
  Work work;

  @JsonKey(name: "thumbnail")
  String thumbnailUri;

  String guid;

  @JsonKey(name: "num_slides")
  int length;

  Image get thumbnail => Image.network(thumbnailUri);

  Book({required this.work, required this.thumbnailUri, required this.guid, required this.length});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class Experience {
  Book book;
  int progress;
  String guid;
  Experience({required this.book, required this.progress, required this.guid});

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}

@JsonSerializable()
class Homepage {
  @JsonKey(name: "current")
  List<Experience>? currentlyReading;

  @JsonKey(name: "recommend")
  List<Book>? recommended;

  Homepage({required this.currentlyReading, required this.recommended});

  factory Homepage.fromJson(Map<String, dynamic> json) => _$HomepageFromJson(json);
  Map<String, dynamic> toJson() => _$HomepageToJson(this);

  Widget currentlyReadingWidget(BuildContext context) {
    return Text('TEST');
  }
}
