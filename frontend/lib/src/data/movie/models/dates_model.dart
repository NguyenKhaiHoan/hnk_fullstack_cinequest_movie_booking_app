import 'package:freezed_annotation/freezed_annotation.dart';

part 'dates_model.freezed.dart';
part 'dates_model.g.dart';

@freezed
abstract class DatesModel with _$DatesModel {
  factory DatesModel({
    DateTime? maximum,
    DateTime? minimum,
  }) = _DatesModel;

  factory DatesModel.fromJson(Map<String, dynamic> json) =>
      _$DatesModelFromJson(json);
}
