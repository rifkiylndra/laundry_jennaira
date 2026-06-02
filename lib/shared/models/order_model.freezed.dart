// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderModel {

 String get id;@JsonKey(name: 'order_no') String get orderNo;@JsonKey(name: 'cust_name') String? get custName;@JsonKey(name: 'cust_phone') String? get custPhone;@JsonKey(name: 'cust_address') String? get custAddress;@JsonKey(name: 'weight_kg') double get weightKg; String get service; int get duration; String get status; int get price; int get discount;@JsonKey(name: 'is_paid') bool get isPaid; String? get notes;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'done_at') DateTime? get doneAt;@JsonKey(name: 'picked_at') DateTime? get pickedAt;
/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderModelCopyWith<OrderModel> get copyWith => _$OrderModelCopyWithImpl<OrderModel>(this as OrderModel, _$identity);

  /// Serializes this OrderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.custName, custName) || other.custName == custName)&&(identical(other.custPhone, custPhone) || other.custPhone == custPhone)&&(identical(other.custAddress, custAddress) || other.custAddress == custAddress)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.service, service) || other.service == service)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.status, status) || other.status == status)&&(identical(other.price, price) || other.price == price)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.doneAt, doneAt) || other.doneAt == doneAt)&&(identical(other.pickedAt, pickedAt) || other.pickedAt == pickedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNo,custName,custPhone,custAddress,weightKg,service,duration,status,price,discount,isPaid,notes,createdAt,doneAt,pickedAt);

@override
String toString() {
  return 'OrderModel(id: $id, orderNo: $orderNo, custName: $custName, custPhone: $custPhone, custAddress: $custAddress, weightKg: $weightKg, service: $service, duration: $duration, status: $status, price: $price, discount: $discount, isPaid: $isPaid, notes: $notes, createdAt: $createdAt, doneAt: $doneAt, pickedAt: $pickedAt)';
}


}

/// @nodoc
abstract mixin class $OrderModelCopyWith<$Res>  {
  factory $OrderModelCopyWith(OrderModel value, $Res Function(OrderModel) _then) = _$OrderModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'order_no') String orderNo,@JsonKey(name: 'cust_name') String? custName,@JsonKey(name: 'cust_phone') String? custPhone,@JsonKey(name: 'cust_address') String? custAddress,@JsonKey(name: 'weight_kg') double weightKg, String service, int duration, String status, int price, int discount,@JsonKey(name: 'is_paid') bool isPaid, String? notes,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'done_at') DateTime? doneAt,@JsonKey(name: 'picked_at') DateTime? pickedAt
});




}
/// @nodoc
class _$OrderModelCopyWithImpl<$Res>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._self, this._then);

  final OrderModel _self;
  final $Res Function(OrderModel) _then;

/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNo = null,Object? custName = freezed,Object? custPhone = freezed,Object? custAddress = freezed,Object? weightKg = null,Object? service = null,Object? duration = null,Object? status = null,Object? price = null,Object? discount = null,Object? isPaid = null,Object? notes = freezed,Object? createdAt = freezed,Object? doneAt = freezed,Object? pickedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNo: null == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String,custName: freezed == custName ? _self.custName : custName // ignore: cast_nullable_to_non_nullable
as String?,custPhone: freezed == custPhone ? _self.custPhone : custPhone // ignore: cast_nullable_to_non_nullable
as String?,custAddress: freezed == custAddress ? _self.custAddress : custAddress // ignore: cast_nullable_to_non_nullable
as String?,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,doneAt: freezed == doneAt ? _self.doneAt : doneAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pickedAt: freezed == pickedAt ? _self.pickedAt : pickedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderModel].
extension OrderModelPatterns on OrderModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderModel value)  $default,){
final _that = this;
switch (_that) {
case _OrderModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'order_no')  String orderNo, @JsonKey(name: 'cust_name')  String? custName, @JsonKey(name: 'cust_phone')  String? custPhone, @JsonKey(name: 'cust_address')  String? custAddress, @JsonKey(name: 'weight_kg')  double weightKg,  String service,  int duration,  String status,  int price,  int discount, @JsonKey(name: 'is_paid')  bool isPaid,  String? notes, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'done_at')  DateTime? doneAt, @JsonKey(name: 'picked_at')  DateTime? pickedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
return $default(_that.id,_that.orderNo,_that.custName,_that.custPhone,_that.custAddress,_that.weightKg,_that.service,_that.duration,_that.status,_that.price,_that.discount,_that.isPaid,_that.notes,_that.createdAt,_that.doneAt,_that.pickedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'order_no')  String orderNo, @JsonKey(name: 'cust_name')  String? custName, @JsonKey(name: 'cust_phone')  String? custPhone, @JsonKey(name: 'cust_address')  String? custAddress, @JsonKey(name: 'weight_kg')  double weightKg,  String service,  int duration,  String status,  int price,  int discount, @JsonKey(name: 'is_paid')  bool isPaid,  String? notes, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'done_at')  DateTime? doneAt, @JsonKey(name: 'picked_at')  DateTime? pickedAt)  $default,) {final _that = this;
switch (_that) {
case _OrderModel():
return $default(_that.id,_that.orderNo,_that.custName,_that.custPhone,_that.custAddress,_that.weightKg,_that.service,_that.duration,_that.status,_that.price,_that.discount,_that.isPaid,_that.notes,_that.createdAt,_that.doneAt,_that.pickedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'order_no')  String orderNo, @JsonKey(name: 'cust_name')  String? custName, @JsonKey(name: 'cust_phone')  String? custPhone, @JsonKey(name: 'cust_address')  String? custAddress, @JsonKey(name: 'weight_kg')  double weightKg,  String service,  int duration,  String status,  int price,  int discount, @JsonKey(name: 'is_paid')  bool isPaid,  String? notes, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'done_at')  DateTime? doneAt, @JsonKey(name: 'picked_at')  DateTime? pickedAt)?  $default,) {final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
return $default(_that.id,_that.orderNo,_that.custName,_that.custPhone,_that.custAddress,_that.weightKg,_that.service,_that.duration,_that.status,_that.price,_that.discount,_that.isPaid,_that.notes,_that.createdAt,_that.doneAt,_that.pickedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderModel implements OrderModel {
  const _OrderModel({required this.id, @JsonKey(name: 'order_no') required this.orderNo, @JsonKey(name: 'cust_name') this.custName, @JsonKey(name: 'cust_phone') this.custPhone, @JsonKey(name: 'cust_address') this.custAddress, @JsonKey(name: 'weight_kg') required this.weightKg, required this.service, required this.duration, this.status = 'diterima', required this.price, this.discount = 0, @JsonKey(name: 'is_paid') this.isPaid = false, this.notes, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'done_at') this.doneAt, @JsonKey(name: 'picked_at') this.pickedAt});
  factory _OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'order_no') final  String orderNo;
@override@JsonKey(name: 'cust_name') final  String? custName;
@override@JsonKey(name: 'cust_phone') final  String? custPhone;
@override@JsonKey(name: 'cust_address') final  String? custAddress;
@override@JsonKey(name: 'weight_kg') final  double weightKg;
@override final  String service;
@override final  int duration;
@override@JsonKey() final  String status;
@override final  int price;
@override@JsonKey() final  int discount;
@override@JsonKey(name: 'is_paid') final  bool isPaid;
@override final  String? notes;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'done_at') final  DateTime? doneAt;
@override@JsonKey(name: 'picked_at') final  DateTime? pickedAt;

/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderModelCopyWith<_OrderModel> get copyWith => __$OrderModelCopyWithImpl<_OrderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.custName, custName) || other.custName == custName)&&(identical(other.custPhone, custPhone) || other.custPhone == custPhone)&&(identical(other.custAddress, custAddress) || other.custAddress == custAddress)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.service, service) || other.service == service)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.status, status) || other.status == status)&&(identical(other.price, price) || other.price == price)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.doneAt, doneAt) || other.doneAt == doneAt)&&(identical(other.pickedAt, pickedAt) || other.pickedAt == pickedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNo,custName,custPhone,custAddress,weightKg,service,duration,status,price,discount,isPaid,notes,createdAt,doneAt,pickedAt);

@override
String toString() {
  return 'OrderModel(id: $id, orderNo: $orderNo, custName: $custName, custPhone: $custPhone, custAddress: $custAddress, weightKg: $weightKg, service: $service, duration: $duration, status: $status, price: $price, discount: $discount, isPaid: $isPaid, notes: $notes, createdAt: $createdAt, doneAt: $doneAt, pickedAt: $pickedAt)';
}


}

/// @nodoc
abstract mixin class _$OrderModelCopyWith<$Res> implements $OrderModelCopyWith<$Res> {
  factory _$OrderModelCopyWith(_OrderModel value, $Res Function(_OrderModel) _then) = __$OrderModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'order_no') String orderNo,@JsonKey(name: 'cust_name') String? custName,@JsonKey(name: 'cust_phone') String? custPhone,@JsonKey(name: 'cust_address') String? custAddress,@JsonKey(name: 'weight_kg') double weightKg, String service, int duration, String status, int price, int discount,@JsonKey(name: 'is_paid') bool isPaid, String? notes,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'done_at') DateTime? doneAt,@JsonKey(name: 'picked_at') DateTime? pickedAt
});




}
/// @nodoc
class __$OrderModelCopyWithImpl<$Res>
    implements _$OrderModelCopyWith<$Res> {
  __$OrderModelCopyWithImpl(this._self, this._then);

  final _OrderModel _self;
  final $Res Function(_OrderModel) _then;

/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNo = null,Object? custName = freezed,Object? custPhone = freezed,Object? custAddress = freezed,Object? weightKg = null,Object? service = null,Object? duration = null,Object? status = null,Object? price = null,Object? discount = null,Object? isPaid = null,Object? notes = freezed,Object? createdAt = freezed,Object? doneAt = freezed,Object? pickedAt = freezed,}) {
  return _then(_OrderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNo: null == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String,custName: freezed == custName ? _self.custName : custName // ignore: cast_nullable_to_non_nullable
as String?,custPhone: freezed == custPhone ? _self.custPhone : custPhone // ignore: cast_nullable_to_non_nullable
as String?,custAddress: freezed == custAddress ? _self.custAddress : custAddress // ignore: cast_nullable_to_non_nullable
as String?,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,doneAt: freezed == doneAt ? _self.doneAt : doneAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pickedAt: freezed == pickedAt ? _self.pickedAt : pickedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
