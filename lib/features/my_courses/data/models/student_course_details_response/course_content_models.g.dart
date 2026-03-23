// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_content_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileContentModel _$FileContentModelFromJson(Map<String, dynamic> json) =>
    FileContentModel(
      filename: json['filename'] as String,
      fileurl: json['fileurl'] as String,
      filesize: (json['filesize'] as num).toInt(),
      timemodified: (json['timemodified'] as num).toInt(),
      mimetype: json['mimetype'] as String,
    );

Map<String, dynamic> _$FileContentModelToJson(FileContentModel instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'fileurl': instance.fileurl,
      'filesize': instance.filesize,
      'timemodified': instance.timemodified,
      'mimetype': instance.mimetype,
    };

ModuleDateModel _$ModuleDateModelFromJson(Map<String, dynamic> json) =>
    ModuleDateModel(
      label: json['label'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      dataid: json['dataid'] as String,
    );

Map<String, dynamic> _$ModuleDateModelToJson(ModuleDateModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'timestamp': instance.timestamp,
      'dataid': instance.dataid,
    };

ModuleModel _$ModuleModelFromJson(Map<String, dynamic> json) => ModuleModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  modname: json['modname'] as String,
  url: json['url'] as String?,
  description: json['description'] as String?,
  uservisible: json['uservisible'] as bool,
  contents: (json['contents'] as List<dynamic>?)
      ?.map((e) => FileContentModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  dates: (json['dates'] as List<dynamic>)
      .map((e) => ModuleDateModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ModuleModelToJson(ModuleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'modname': instance.modname,
      'url': instance.url,
      'description': instance.description,
      'uservisible': instance.uservisible,
      'contents': instance.contents,
      'dates': instance.dates,
    };

SectionModel _$SectionModelFromJson(Map<String, dynamic> json) => SectionModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  section: (json['section'] as num).toInt(),
  uservisible: json['uservisible'] as bool,
  modules: (json['modules'] as List<dynamic>)
      .map((e) => ModuleModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SectionModelToJson(SectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'section': instance.section,
      'uservisible': instance.uservisible,
      'modules': instance.modules,
    };
