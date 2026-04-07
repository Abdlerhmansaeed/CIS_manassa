import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'action.g.dart';

@JsonSerializable()
class Action extends Equatable {
  final String? name;
  final String? url;
  final int? itemcount;
  final bool? actionable;
  final bool? showitemcount;

  const Action({
    this.name,
    this.url,
    this.itemcount,
    this.actionable,
    this.showitemcount,
  });

  factory Action.fromJson(Map<String, dynamic> json) {
    return _$ActionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActionToJson(this);

  Action copyWith({
    String? name,
    String? url,
    int? itemcount,
    bool? actionable,
    bool? showitemcount,
  }) {
    return Action(
      name: name ?? this.name,
      url: url ?? this.url,
      itemcount: itemcount ?? this.itemcount,
      actionable: actionable ?? this.actionable,
      showitemcount: showitemcount ?? this.showitemcount,
    );
  }

  @override
  List<Object?> get props {
    return [name, url, itemcount, actionable, showitemcount];
  }
}
