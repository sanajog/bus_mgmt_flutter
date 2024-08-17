import 'package:json_annotation/json_annotation.dart';

part 'bus_api_model.g.dart';

@JsonSerializable()
class BusApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? decsription;
  final String? busType;
  final String? ticketPrice;
  final String? image;
  BusApiModel({
    this.id,
    this.title,
    this.decsription,
    this.busType,
    this.ticketPrice,
    this.image,
  });

  factory BusApiModel.fromJson(Map<String, dynamic> json) =>
      _$BusApiModelFromJson(json);
      
      Map<String, dynamic> toJson() => _$BusApiModelToJson(this);
}
