// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => _OrderItem(
  serviceName: json['service_name'] as String,
  weightOrQty: (json['weight_or_qty'] as num).toDouble(),
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$OrderItemToJson(_OrderItem instance) =>
    <String, dynamic>{
      'service_name': instance.serviceName,
      'weight_or_qty': instance.weightOrQty,
      'price': instance.price,
    };

_OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => _OrderModel(
  id: json['id'] as String,
  orderNo: json['order_no'] as String,
  custName: json['cust_name'] as String?,
  custPhone: json['cust_phone'] as String?,
  custAddress: json['cust_address'] as String?,
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  durationDays: (json['duration_days'] as num).toInt(),
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
      'items': instance.items,
      'duration_days': instance.durationDays,
      'status': instance.status,
      'price': instance.price,
      'discount': instance.discount,
      'is_paid': instance.isPaid,
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'done_at': instance.doneAt?.toIso8601String(),
      'picked_at': instance.pickedAt?.toIso8601String(),
    };
