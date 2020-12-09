import 'package:json_annotation/json_annotation.dart';

//partial
part 'history.g.dart';

@JsonSerializable()
class History {

  History(
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
      this.longitude);

  final String title;
  final String description;
  final String city;
  final String address;
  final String site;
  final String mainSocialNetwork;
  final String otherSocialNetwork;
  final int numberTrue;
  final int numberFalse;
  final List<String> tags;
  final double latitude;
  final double longitude;

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);

}
