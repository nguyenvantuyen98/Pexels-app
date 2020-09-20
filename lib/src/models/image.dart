import 'package:equatable/equatable.dart';

import 'image_src.dart';

class Photo extends Equatable {
  Photo(
      {this.id,
      this.width,
      this.height,
      this.url,
      this.photographer,
      this.photographer_url,
      this.photographer_id,
      this.src});
  final int id;
  final int width;
  final int height;
  final String url;
  final String photographer;
  final String photographer_url;
  final int photographer_id;
  final ImageSrc src;

  factory Photo.fromMap(Map<String, dynamic> map) => Photo(
      id: map['id'],
      width: map['width'],
      height: map['height'],
      url: map['url'],
      photographer: map['photographer'],
      photographer_url: map['photographer_url'],
      photographer_id: map['photographer_id'],
      src: ImageSrc.fromMap(map['src']));

  @override
  List<Object> get props => [
        id,
        width,
        height,
        url,
        photographer,
        photographer_url,
        photographer_id,
        src
      ];

  @override
  String toString() => '''
  id: $id,
  width: $width,
  height: $height,
  url: $url,
  photographer: $photographer,
  photographer_url: $photographer_url,
  photographer_id: $photographer_id,
  src: $src''';
}
