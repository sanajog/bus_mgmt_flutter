// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusApiModel _$BusApiModelFromJson(Map<String, dynamic> json) => BusApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      decsription: json['decsription'] as String?,
      busType: json['busType'] as String?,
      ticketPrice: json['ticketPrice'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$BusApiModelToJson(BusApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'decsription': instance.decsription,
      'busType': instance.busType,
      'ticketPrice': instance.ticketPrice,
      'image': instance.image,
    };
