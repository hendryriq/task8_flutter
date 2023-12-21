// To parse this JSON data, do
//
//     final resMusic = resMusicFromJson(jsonString);

import 'dart:convert';

ResMusic resMusicFromJson(String str) => ResMusic.fromJson(json.decode(str));

String resMusicToJson(ResMusic data) => json.encode(data.toJson());

class ResMusic {
  bool isSuccess;
  String message;
  List<ListMusic> data;

  ResMusic({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ResMusic.fromJson(Map<String, dynamic> json) => ResMusic(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<ListMusic>.from(json["data"].map((x) => ListMusic.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ListMusic {
  String id;
  String name;
  String author;
  String cover;
  String path;

  ListMusic({
    required this.id,
    required this.name,
    required this.author,
    required this.cover,
    required this.path,
  });

  factory ListMusic.fromJson(Map<String, dynamic> json) => ListMusic(
    id: json["id"],
    name: json["name"],
    author: json["author"],
    cover: json["cover"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "author": author,
    "cover": cover,
    "path": path,
  };
}
