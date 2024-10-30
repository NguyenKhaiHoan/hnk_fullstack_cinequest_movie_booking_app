import 'package:freezed_annotation/freezed_annotation.dart';

part 'crew_model.freezed.dart';
part 'crew_model.g.dart';

@freezed
class CrewModel with _$CrewModel {
  factory CrewModel({
    @JsonKey(name: 'adult') bool? isAdult,
    int? gender,
    int? id,
    @JsonKey(name: 'known_for_department') String? knownForDepartment,
    String? name,
    @JsonKey(name: 'original_name') String? originalName,
    double? popularity,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'credit_id') String? creditId,
    String? department,
    String? job,
  }) = _CrewModel;

  factory CrewModel.fromJson(Map<String, dynamic> json) =>
      _$CrewModelFromJson(json);
}
