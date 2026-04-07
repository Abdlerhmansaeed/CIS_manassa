// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Action _$ActionFromJson(Map<String, dynamic> json) => Action(
  name: json['name'] as String?,
  url: json['url'] as String?,
  itemcount: (json['itemcount'] as num?)?.toInt(),
  actionable: json['actionable'] as bool?,
  showitemcount: json['showitemcount'] as bool?,
);

Map<String, dynamic> _$ActionToJson(Action instance) => <String, dynamic>{
  'name': instance.name,
  'url': instance.url,
  'itemcount': instance.itemcount,
  'actionable': instance.actionable,
  'showitemcount': instance.showitemcount,
};
