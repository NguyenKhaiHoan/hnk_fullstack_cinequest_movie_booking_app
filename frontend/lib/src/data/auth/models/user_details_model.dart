import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_details_model.freezed.dart';
part 'user_details_model.g.dart';

@freezed
class UserDetailsModel with _$UserDetailsModel {
  const factory UserDetailsModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'surname') String? surname,
    @JsonKey(name: 'bio') String? bio,
    @JsonKey(name: 'profile_photo') String? profilePhoto,
  }) = _UserDetailsModel;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsModelFromJson(json);
}
