import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

@JsonSerializable()
class Subscription extends Equatable {
  final bool? displayeventsource;

  const Subscription({this.displayeventsource});

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  Subscription copyWith({bool? displayeventsource}) {
    return Subscription(
      displayeventsource: displayeventsource ?? this.displayeventsource,
    );
  }

  @override
  List<Object?> get props => [displayeventsource];
}
