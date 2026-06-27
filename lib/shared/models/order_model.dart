// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
abstract class OrderItem with _$OrderItem {
  const factory OrderItem({
    @JsonKey(name: 'service_name') required String serviceName,
    @JsonKey(name: 'weight_or_qty') required double weightOrQty,
    required double price,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

@freezed
abstract class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    @JsonKey(name: 'order_no') required String orderNo,
    @JsonKey(name: 'cust_name') String? custName,
    @JsonKey(name: 'cust_phone') String? custPhone,
    @JsonKey(name: 'cust_address') String? custAddress,
    required List<OrderItem> items,
    @JsonKey(name: 'duration_days') required int durationDays,
    @Default('diterima') String status,
    required int price,
    @Default(0) int discount,
    @JsonKey(name: 'is_paid') @Default(false) bool isPaid,
    String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'done_at') DateTime? doneAt,
    @JsonKey(name: 'picked_at') DateTime? pickedAt,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final mutableJson = Map<String, dynamic>.from(json);
    
    // Legacy support for older records without 'items' array
    if (mutableJson['items'] == null) {
      mutableJson['items'] = [
        {
          'service_name': mutableJson['service'] ?? 'Cuci Gosok',
          'weight_or_qty': (mutableJson['weight_kg'] ?? 1).toDouble(),
          'price': (mutableJson['price'] ?? 0).toDouble(), 
        }
      ];
    }
    
    // Legacy support for older records without 'duration_days'
    if (mutableJson['duration_days'] == null) {
      mutableJson['duration_days'] = mutableJson['duration'] ?? 3;
    }
    
    return _$OrderModelFromJson(mutableJson);
  }
}

extension OrderModelX on OrderModel {
  String get remainingDaysText {
    if (createdAt == null) return '';
    if (status == 'selesai' || status == 'diambil' || status == 'dibatalkan') return '';

    final expectedDate = createdAt!.add(Duration(days: durationDays));
    final now = DateTime.now();
    
    // Normalize to dates only for difference
    final expectedDateOnly = DateTime(expectedDate.year, expectedDate.month, expectedDate.day);
    final nowOnly = DateTime(now.year, now.month, now.day);
    
    final days = expectedDateOnly.difference(nowOnly).inDays;
    
    if (days < 0) {
      return '(Terlambat ${days.abs()} Hari)';
    } else if (days == 0) {
      return '(Selesai Hari Ini)';
    } else {
      return '(Sisa $days Hari)';
    }
  }
}
