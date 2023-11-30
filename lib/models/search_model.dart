// To parse this JSON data, do
//
//     final getSearch = getSearchFromJson(jsonString);

import 'dart:convert';

import 'package:guide/models/classes/place_class.dart';

GetSearch getSearchFromJson(String str) => GetSearch.fromJson(json.decode(str));

String getSearchToJson(GetSearch data) => json.encode(data.toJson());

class GetSearch {
  int? totalCount;
  int? perPage;
  int? fromRecord;
  int? toRecord;
  int? previousPage;
  int? nextPage;
  int? currentPage;
  int? pageCount;
  List<Place>? data;

  GetSearch({
    this.totalCount,
    this.perPage,
    this.fromRecord,
    this.toRecord,
    this.previousPage,
    this.nextPage,
    this.currentPage,
    this.pageCount,
    this.data,
  });

  factory GetSearch.fromJson(Map<String, dynamic> json) => GetSearch(
        totalCount: json["total_count"],
        perPage: json["per_page"],
        fromRecord: json["from_record"],
        toRecord: json["to_record"],
        previousPage: json["previous_page"],
        nextPage: json["next_page"],
        currentPage: json["current_page"],
        pageCount: json["page_count"],
        data: json["data"] == null
            ? []
            : List<Place>.from(json["data"]!.map((x) => Place.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "per_page": perPage,
        "from_record": fromRecord,
        "to_record": toRecord,
        "previous_page": previousPage,
        "next_page": nextPage,
        "current_page": currentPage,
        "page_count": pageCount,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
