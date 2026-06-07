// ignore_for_file: invalid_annotation_target
// lib/shared/models/inventory_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_model.freezed.dart';
part 'inventory_model.g.dart';

@freezed
abstract class InventoryModel with _$InventoryModel {
  factory InventoryModel({
    required String id,
    required String name,
    required String unit,
    @Default(0.0) double stock,
    @Default(1.0) double minStock,
    @JsonKey(name: 'cost_per_unit') @Default(0) int costPerUnit,
  }) = _InventoryModel;

  factory InventoryModel.fromJson(Map<String, dynamic> json) => _$InventoryModelFromJson(json);
}
