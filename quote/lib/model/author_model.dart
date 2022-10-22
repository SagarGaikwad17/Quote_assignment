// To parse this JSON data, do
//
//     final authorResponse = authorResponseFromJson(jsonString);

import 'dart:convert';

AuthorResponse authorResponseFromJson(String str) =>
    AuthorResponse.fromJson(json.decode(str));

String authorResponseToJson(AuthorResponse data) => json.encode(data.toJson());

class AuthorResponse {
  AuthorResponse({
    this.count,
    this.totalCount,
    this.page,
    this.totalPages,
    this.lastItemIndex,
    this.results,
  });

  int? count;
  int? totalCount;
  int? page;
  int? totalPages;
  dynamic lastItemIndex;
  List<Result>? results;

  factory AuthorResponse.fromJson(Map<String, dynamic> json) => AuthorResponse(
        count: json["count"],
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        lastItemIndex: json["lastItemIndex"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "lastItemIndex": lastItemIndex,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.link,
    this.bio,
    this.description,
    this.quoteCount,
    this.slug,
    this.dateAdded,
    this.dateModified,
  });

  String? id;
  String? name;
  String? link;
  String? bio;
  String? description;
  int? quoteCount;
  String? slug;
  DateTime? dateAdded;
  DateTime? dateModified;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        name: json["name"],
        link: json["link"],
        bio: json["bio"],
        description: json["description"],
        quoteCount: json["quoteCount"],
        slug: json["slug"],
        dateAdded: DateTime.parse(json["dateAdded"]),
        dateModified: DateTime.parse(json["dateModified"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "link": link,
        "bio": bio,
        "description": description,
        "quoteCount": quoteCount,
        "slug": slug,
        "dateAdded":
            "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
        "dateModified":
            "${dateModified!.year.toString().padLeft(4, '0')}-${dateModified!.month.toString().padLeft(2, '0')}-${dateModified!.day.toString().padLeft(2, '0')}",
      };
}
