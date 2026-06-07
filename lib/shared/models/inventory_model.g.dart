// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InventoryModel _$InventoryModelFromJson(Map<String, dynamic> json) =>
    _InventoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      stock: (json['stock'] as num?)?.toDouble() ?? 0.0,
      minStock: (json['minStock'] as num?)?.toDouble() ?? 1.0,
      costPerUnit: (json['cost_per_unit'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$InventoryModelToJson(_InventoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unit': instance.unit,
      'stock': instance.stock,
      'minStock': instance.minStock,
      'cost_per_unit': instance.costPerUnit,
    };
