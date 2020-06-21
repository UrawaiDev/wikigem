// To parse this JSON data, do
//
//     final gameTrailers = gameTrailersFromJson(jsonString);

import 'dart:convert';

GameTrailers gameTrailersFromJson(String str) =>
    GameTrailers.fromJson(json.decode(str));

String gameTrailersToJson(GameTrailers data) => json.encode(data.toJson());

class GameTrailers {
  GameTrailers({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  final int count;
  final dynamic next;
  final dynamic previous;
  final List<Result> results;

  factory GameTrailers.fromJson(Map<String, dynamic> json) => GameTrailers(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.preview,
    this.data,
  });

  final int id;
  final String name;
  final String preview;
  final Data data;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        preview: json["preview"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "preview": preview,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.the480,
    this.max,
  });

  final String the480;
  final String max;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        the480: json["480"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "480": the480,
        "max": max,
      };
}
