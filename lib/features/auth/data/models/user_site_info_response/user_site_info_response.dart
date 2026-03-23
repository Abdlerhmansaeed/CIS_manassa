import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_site_info_response.g.dart';

@JsonSerializable()
class UserSiteInfoResponse extends Equatable {
  final int? userid;
  final String? username;
  final String? fullname;
  final String? userpictureurl;

  const UserSiteInfoResponse({
    this.userid,
    this.username,
    this.fullname,
    this.userpictureurl,
  });

  factory UserSiteInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSiteInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserSiteInfoResponseToJson(this);

  @override
  List<Object?> get props => [userid, username, fullname, userpictureurl];
}
