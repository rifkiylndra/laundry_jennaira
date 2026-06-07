// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toInt(),
      categoryId: json['category_id'] as String?,
      orderId: json['order_id'] as String?,
      description: json['note'] as String?,
      photoUrl: json['photo_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'category_id': instance.categoryId,
      'order_id': instance.orderId,
      'note': instance.description,
      'photo_url': instance.photoUrl,
      'created_at': instance.createdAt.toIso8601String(),
    };
