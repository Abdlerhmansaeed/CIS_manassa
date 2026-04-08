import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'icon.g.dart';

@JsonSerializable()
class Icon extends Equatable {
  final String? key;
  final String? component;
  final String? alttext;
  final String? iconurl;
  final String? iconclass;

  const Icon({
    this.key,
    this.component,
    this.alttext,
    this.iconurl,
    this.iconclass,
  });

  factory Icon.fromJson(Map<String, dynamic> json) => _$IconFromJson(json);

  Map<String, dynamic> toJson() => _$IconToJson(this);

  Icon copyWith({
    String? key,
    String? component,
    String? alttext,
    String? iconurl,
    String? iconclass,
  }) {
    return Icon(
      key: key ?? this.key,
      component: component ?? this.component,
      alttext: alttext ?? this.alttext,
      iconurl: iconurl ?? this.iconurl,
      iconclass: iconclass ?? this.iconclass,
    );
  }

  @override
  List<Object?> get props {
    return [key, component, alttext, iconurl, iconclass];
  }
}
