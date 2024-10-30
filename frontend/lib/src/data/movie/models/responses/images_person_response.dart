import 'package:cinequest/src/data/movie/models/profile_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'images_person_response.freezed.dart';
part 'images_person_response.g.dart';

@freezed
class ImagesPersonResponse with _$ImagesPersonResponse {
  const factory ImagesPersonResponse({
    required int id,
    required List<ProfileModel> profiles,
  }) = _ImagesPersonResponse;

  factory ImagesPersonResponse.fromJson(Map<String, dynamic> json) =>
      _$ImagesPersonResponseFromJson(json);
}
