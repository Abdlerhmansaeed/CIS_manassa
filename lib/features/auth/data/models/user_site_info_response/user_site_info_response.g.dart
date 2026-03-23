// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_site_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSiteInfoResponse _$UserSiteInfoResponseFromJson(
  Map<String, dynamic> json,
) => UserSiteInfoResponse(
  userid: (json['userid'] as num?)?.toInt(),
  username: json['username'] as String?,
  fullname: json['fullname'] as String?,
  userpictureurl: json['userpictureurl'] as String?,
);

Map<String, dynamic> _$UserSiteInfoResponseToJson(
  UserSiteInfoResponse instance,
) => <String, dynamic>{
  'userid': instance.userid,
  'username': instance.username,
  'fullname': instance.fullname,
  'userpictureurl': instance.userpictureurl,
};
