// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
abstract class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    @JsonKey(name: 'order_no') required String orderNo,
    @JsonKey(name: 'cust_name') String? custName,
    @JsonKey(name: 'cust_phone') String? custPhone,
    @JsonKey(name: 'cust_address') String? custAddress,
    @JsonKey(name: 'weight_kg') required double weightKg,
    required String service,
    required int duration,
    @Default('diterima') String status,
    required int price,
    @Default(0) int discount,
    @JsonKey(name: 'is_paid') @Default(false) bool isPaid,
    String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'done_at') DateTime? doneAt,
    @JsonKey(name: 'picked_at') DateTime? pickedAt,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
