import 'package:json_annotation/json_annotation.dart';

part 'course_content_models.g.dart';

// ─── File Content ───────────────────────────────────────────
@JsonSerializable()
class FileContentModel {
  final String filename;
  final String fileurl;
  final int filesize;
  final int timemodified;
  final String mimetype;

  FileContentModel({
    required this.filename,
    required this.fileurl,
    required this.filesize,
    required this.timemodified,
    required this.mimetype,
  });

  factory FileContentModel.fromJson(Map<String, dynamic> json) =>
      _$FileContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileContentModelToJson(this);
}

// ─── Module Date ─────────────────────────────────────────────
@JsonSerializable()
class ModuleDateModel {
  final String label;
  final int timestamp;
  final String dataid;

  ModuleDateModel({
    required this.label,
    required this.timestamp,
    required this.dataid,
  });

  factory ModuleDateModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleDateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleDateModelToJson(this);
}

// ─── Module ──────────────────────────────────────────────────
@JsonSerializable()
class ModuleModel {
  final int id;
  final String name;
  final String modname;
  final String? url;
  final String? description;
  final bool uservisible;
  final List<FileContentModel>? contents;
  final List<ModuleDateModel> dates;

  ModuleModel({
    required this.id,
    required this.name,
    required this.modname,
    this.url,
    this.description,
    required this.uservisible,
    this.contents,
    required this.dates,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleModelToJson(this);
}

// ─── Section ─────────────────────────────────────────────────
@JsonSerializable()
class SectionModel {
  final int id;
  final String name;
  final int section;
  final bool uservisible;
  final List<ModuleModel> modules;

  SectionModel({
    required this.id,
    required this.name,
    required this.section,
    required this.uservisible,
    required this.modules,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SectionModelToJson(this);
}
