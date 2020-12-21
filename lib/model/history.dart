import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

//partial
part 'history.g.dart';

@JsonSerializable()
class History {

  History({
    this.title,
    this.description,
    this.city,
    this.address,
    this.site,
    this.mainSocialNetwork,
    this.otherSocialNetwork,
    this.numberTrue,
    this.numberFalse,
    this.tags,
    this.latitude,
    this.longitude
  });

  History.full(
    this.title,
    this.description,
    this.city,
    this.address,
    this.site,
    this.mainSocialNetwork,
    this.otherSocialNetwork,
    this.numberTrue,
    this.numberFalse,
    this.tags,
    this.latitude,
    this.longitude
  );

  final String title;
  final String description;
  final String city;
  final String address;
  final String site;
  final String mainSocialNetwork;
  final String otherSocialNetwork;
  int numberTrue;
  int numberFalse;
  final List<String> tags;
  final double latitude;
  final double longitude;

  DocumentReference reference;

  factory History.fromJson(DocumentReference reference, Map<String, dynamic> json) {
    History history = _$HistoryFromJson(json);
    history.reference = reference;
    return history;
  }

  Map<String, dynamic> toJson() => _$HistoryToJson(this);

}
