import 'package:equatable/equatable.dart';

class VideoFile extends Equatable {
  VideoFile(
      {this.id,
        this.quality,
        this.file_type,
        this.width,
        this.height,
        this.link});
  final int id;
  final String quality;
  final String file_type;
  final int width;
  final int height;
  final String link;

  factory VideoFile.fromMap(Map<String, dynamic> map) => VideoFile(
      id: map['id'],
      quality: map['quality'],
      file_type: map['file_type'],
      width: map['width'],
      height: map['height'],
      link: map['link']);

  @override
  List<Object> get props => [id, quality, file_type, width, height, link];

  @override
  String toString() => '''
  id: $id,
  quality: $quality,
  file_type: $file_type,
  width: $width,
  height: $height,
  link: $link
  ''';
}
