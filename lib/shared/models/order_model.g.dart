// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => _OrderModel(
  id: json['id'] as String,
  orderNo: json['order_no'] as String,
  custName: json['cust_name'] as String?,
  custPhone: json['cust_phone'] as String?,
  custAddress: json['cust_address'] as String?,
  weightKg: (json['weight_kg'] as num).toDouble(),
  service: json['service'] as String,
  duration: (json['duration'] as num).toInt(),
  status: json['status'] as String? ?? 'diterima',
  price: (json['price'] as num).toInt(),
  discount: (json['discount'] as num?)?.toInt() ?? 0,
  isPaid: json['is_paid'] as bool? ?? false,
  notes: json['notes'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  doneAt: json['done_at'] == null
      ? null
      : DateTime.parse(json['done_at'] as String),
  pickedAt: json['picked_at'] == null
      ? null
      : DateTime.parse(json['picked_at'] as String),
);

Map<String, dynamic> _$OrderModelToJson(_OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_no': instance.orderNo,
      'cust_name': instance.custName,
      'cust_phone': instance.custPhone,
      'cust_address': instance.custAddress,
      'weight_kg': instance.weightKg,
      'service': instance.service,
      'duration': instance.duration,
      'status': instance.status,
      'price': instance.price,
      'discount': instance.discount,
      'is_paid': instance.isPaid,
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'done_at': instance.doneAt?.toIso8601String(),
      'picked_at': instance.pickedAt?.toIso8601String(),
    };
