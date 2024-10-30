import 'package:freezed_annotation/freezed_annotation.dart';

part 'spoken_language_model.freezed.dart';
part 'spoken_language_model.g.dart';

@freezed
class SpokenLanguageModel with _$SpokenLanguageModel {
  const factory SpokenLanguageModel({
    @JsonKey(name: 'english_name') required String englishName,
    @JsonKey(name: 'iso_639_1') required String iso6391,
    required String name,
  }) = _SpokenLanguageModel;

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageModelFromJson(json);
}
