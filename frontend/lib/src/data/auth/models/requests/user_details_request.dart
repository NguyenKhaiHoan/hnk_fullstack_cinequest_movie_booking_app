import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_details_request.freezed.dart';
part 'user_details_request.g.dart';

@freezed
abstract class UserDetailsRequest with _$UserDetailsRequest {
  factory UserDetailsRequest({
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'surname') required String surname,
    @JsonKey(name: 'bio') required String bio,
    @JsonKey(name: 'profile_photo') required String profilePhoto,
  }) = _UserDetailsRequest;

  factory UserDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsRequestFromJson(json);
}
