// lib/shared/models/profile_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    required String name,
    required String role,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => 
      _$ProfileModelFromJson(json);
}
