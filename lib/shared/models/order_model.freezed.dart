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
mixin _$OrderItem {

@JsonKey(name: 'service_name') String get serviceName;@JsonKey(name: 'weight_or_qty') double get weightOrQty; double get price;
/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemCopyWith<OrderItem> get copyWith => _$OrderItemCopyWithImpl<OrderItem>(this as OrderItem, _$identity);

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItem&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.weightOrQty, weightOrQty) || other.weightOrQty == weightOrQty)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceName,weightOrQty,price);

@override
String toString() {
  return 'OrderItem(serviceName: $serviceName, weightOrQty: $weightOrQty, price: $price)';
}


}

/// @nodoc
abstract mixin class $OrderItemCopyWith<$Res>  {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) _then) = _$OrderItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'service_name') String serviceName,@JsonKey(name: 'weight_or_qty') double weightOrQty, double price
});




}
/// @nodoc
class _$OrderItemCopyWithImpl<$Res>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._self, this._then);

  final OrderItem _self;
  final $Res Function(OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceName = null,Object? weightOrQty = null,Object? price = null,}) {
  return _then(_self.copyWith(
serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,weightOrQty: null == weightOrQty ? _self.weightOrQty : weightOrQty // ignore: cast_nullable_to_non_nullable
as double,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderItem].
extension OrderItemPatterns on OrderItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItem value)  $default,){
final _that = this;
switch (_that) {
case _OrderItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItem value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'service_name')  String serviceName, @JsonKey(name: 'weight_or_qty')  double weightOrQty,  double price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
return $default(_that.serviceName,_that.weightOrQty,_that.price);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'service_name')  String serviceName, @JsonKey(name: 'weight_or_qty')  double weightOrQty,  double price)  $default,) {final _that = this;
switch (_that) {
case _OrderItem():
return $default(_that.serviceName,_that.weightOrQty,_that.price);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'service_name')  String serviceName, @JsonKey(name: 'weight_or_qty')  double weightOrQty,  double price)?  $default,) {final _that = this;
switch (_that) {
case _OrderItem() when $default != null:
return $default(_that.serviceName,_that.weightOrQty,_that.price);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderItem implements OrderItem {
  const _OrderItem({@JsonKey(name: 'service_name') required this.serviceName, @JsonKey(name: 'weight_or_qty') required this.weightOrQty, required this.price});
  factory _OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

@override@JsonKey(name: 'service_name') final  String serviceName;
@override@JsonKey(name: 'weight_or_qty') final  double weightOrQty;
@override final  double price;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemCopyWith<_OrderItem> get copyWith => __$OrderItemCopyWithImpl<_OrderItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItem&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.weightOrQty, weightOrQty) || other.weightOrQty == weightOrQty)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceName,weightOrQty,price);

@override
String toString() {
  return 'OrderItem(serviceName: $serviceName, weightOrQty: $weightOrQty, price: $price)';
}


}

/// @nodoc
abstract mixin class _$OrderItemCopyWith<$Res> implements $OrderItemCopyWith<$Res> {
  factory _$OrderItemCopyWith(_OrderItem value, $Res Function(_OrderItem) _then) = __$OrderItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'service_name') String serviceName,@JsonKey(name: 'weight_or_qty') double weightOrQty, double price
});




}
/// @nodoc
class __$OrderItemCopyWithImpl<$Res>
    implements _$OrderItemCopyWith<$Res> {
  __$OrderItemCopyWithImpl(this._self, this._then);

  final _OrderItem _self;
  final $Res Function(_OrderItem) _then;

/// Create a copy of OrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceName = null,Object? weightOrQty = null,Object? price = null,}) {
  return _then(_OrderItem(
serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,weightOrQty: null == weightOrQty ? _self.weightOrQty : weightOrQty // ignore: cast_nullable_to_non_nullable
as double,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$OrderModel {

 String get id;@JsonKey(name: 'order_no') String get orderNo;@JsonKey(name: 'cust_name') String? get custName;@JsonKey(name: 'cust_phone') String? get custPhone;@JsonKey(name: 'cust_address') String? get custAddress; List<OrderItem> get items;@JsonKey(name: 'duration_days') int get durationDays; String get status; int get price; int get discount;@JsonKey(name: 'is_paid') bool get isPaid; String? get notes;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'done_at') DateTime? get doneAt;@JsonKey(name: 'picked_at') DateTime? get pickedAt;
/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderModelCopyWith<OrderModel> get copyWith => _$OrderModelCopyWithImpl<OrderModel>(this as OrderModel, _$identity);

  /// Serializes this OrderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.custName, custName) || other.custName == custName)&&(identical(other.custPhone, custPhone) || other.custPhone == custPhone)&&(identical(other.custAddress, custAddress) || other.custAddress == custAddress)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.status, status) || other.status == status)&&(identical(other.price, price) || other.price == price)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.doneAt, doneAt) || other.doneAt == doneAt)&&(identical(other.pickedAt, pickedAt) || other.pickedAt == pickedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNo,custName,custPhone,custAddress,const DeepCollectionEquality().hash(items),durationDays,status,price,discount,isPaid,notes,createdAt,doneAt,pickedAt);

@override
String toString() {
  return 'OrderModel(id: $id, orderNo: $orderNo, custName: $custName, custPhone: $custPhone, custAddress: $custAddress, items: $items, durationDays: $durationDays, status: $status, price: $price, discount: $discount, isPaid: $isPaid, notes: $notes, createdAt: $createdAt, doneAt: $doneAt, pickedAt: $pickedAt)';
}


}

/// @nodoc
abstract mixin class $OrderModelCopyWith<$Res>  {
  factory $OrderModelCopyWith(OrderModel value, $Res Function(OrderModel) _then) = _$OrderModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'order_no') String orderNo,@JsonKey(name: 'cust_name') String? custName,@JsonKey(name: 'cust_phone') String? custPhone,@JsonKey(name: 'cust_address') String? custAddress, List<OrderItem> items,@JsonKey(name: 'duration_days') int durationDays, String status, int price, int discount,@JsonKey(name: 'is_paid') bool isPaid, String? notes,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'done_at') DateTime? doneAt,@JsonKey(name: 'picked_at') DateTime? pickedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderNo = null,Object? custName = freezed,Object? custPhone = freezed,Object? custAddress = freezed,Object? items = null,Object? durationDays = null,Object? status = null,Object? price = null,Object? discount = null,Object? isPaid = null,Object? notes = freezed,Object? createdAt = freezed,Object? doneAt = freezed,Object? pickedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNo: null == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String,custName: freezed == custName ? _self.custName : custName // ignore: cast_nullable_to_non_nullable
as String?,custPhone: freezed == custPhone ? _self.custPhone : custPhone // ignore: cast_nullable_to_non_nullable
as String?,custAddress: freezed == custAddress ? _self.custAddress : custAddress // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'order_no')  String orderNo, @JsonKey(name: 'cust_name')  String? custName, @JsonKey(name: 'cust_phone')  String? custPhone, @JsonKey(name: 'cust_address')  String? custAddress,  List<OrderItem> items, @JsonKey(name: 'duration_days')  int durationDays,  String status,  int price,  int discount, @JsonKey(name: 'is_paid')  bool isPaid,  String? notes, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'done_at')  DateTime? doneAt, @JsonKey(name: 'picked_at')  DateTime? pickedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
return $default(_that.id,_that.orderNo,_that.custName,_that.custPhone,_that.custAddress,_that.items,_that.durationDays,_that.status,_that.price,_that.discount,_that.isPaid,_that.notes,_that.createdAt,_that.doneAt,_that.pickedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'order_no')  String orderNo, @JsonKey(name: 'cust_name')  String? custName, @JsonKey(name: 'cust_phone')  String? custPhone, @JsonKey(name: 'cust_address')  String? custAddress,  List<OrderItem> items, @JsonKey(name: 'duration_days')  int durationDays,  String status,  int price,  int discount, @JsonKey(name: 'is_paid')  bool isPaid,  String? notes, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'done_at')  DateTime? doneAt, @JsonKey(name: 'picked_at')  DateTime? pickedAt)  $default,) {final _that = this;
switch (_that) {
case _OrderModel():
return $default(_that.id,_that.orderNo,_that.custName,_that.custPhone,_that.custAddress,_that.items,_that.durationDays,_that.status,_that.price,_that.discount,_that.isPaid,_that.notes,_that.createdAt,_that.doneAt,_that.pickedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'order_no')  String orderNo, @JsonKey(name: 'cust_name')  String? custName, @JsonKey(name: 'cust_phone')  String? custPhone, @JsonKey(name: 'cust_address')  String? custAddress,  List<OrderItem> items, @JsonKey(name: 'duration_days')  int durationDays,  String status,  int price,  int discount, @JsonKey(name: 'is_paid')  bool isPaid,  String? notes, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'done_at')  DateTime? doneAt, @JsonKey(name: 'picked_at')  DateTime? pickedAt)?  $default,) {final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
return $default(_that.id,_that.orderNo,_that.custName,_that.custPhone,_that.custAddress,_that.items,_that.durationDays,_that.status,_that.price,_that.discount,_that.isPaid,_that.notes,_that.createdAt,_that.doneAt,_that.pickedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderModel implements OrderModel {
  const _OrderModel({required this.id, @JsonKey(name: 'order_no') required this.orderNo, @JsonKey(name: 'cust_name') this.custName, @JsonKey(name: 'cust_phone') this.custPhone, @JsonKey(name: 'cust_address') this.custAddress, required final  List<OrderItem> items, @JsonKey(name: 'duration_days') required this.durationDays, this.status = 'diterima', required this.price, this.discount = 0, @JsonKey(name: 'is_paid') this.isPaid = false, this.notes, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'done_at') this.doneAt, @JsonKey(name: 'picked_at') this.pickedAt}): _items = items;
  factory _OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'order_no') final  String orderNo;
@override@JsonKey(name: 'cust_name') final  String? custName;
@override@JsonKey(name: 'cust_phone') final  String? custPhone;
@override@JsonKey(name: 'cust_address') final  String? custAddress;
 final  List<OrderItem> _items;
@override List<OrderItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(name: 'duration_days') final  int durationDays;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderNo, orderNo) || other.orderNo == orderNo)&&(identical(other.custName, custName) || other.custName == custName)&&(identical(other.custPhone, custPhone) || other.custPhone == custPhone)&&(identical(other.custAddress, custAddress) || other.custAddress == custAddress)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.status, status) || other.status == status)&&(identical(other.price, price) || other.price == price)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.doneAt, doneAt) || other.doneAt == doneAt)&&(identical(other.pickedAt, pickedAt) || other.pickedAt == pickedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderNo,custName,custPhone,custAddress,const DeepCollectionEquality().hash(_items),durationDays,status,price,discount,isPaid,notes,createdAt,doneAt,pickedAt);

@override
String toString() {
  return 'OrderModel(id: $id, orderNo: $orderNo, custName: $custName, custPhone: $custPhone, custAddress: $custAddress, items: $items, durationDays: $durationDays, status: $status, price: $price, discount: $discount, isPaid: $isPaid, notes: $notes, createdAt: $createdAt, doneAt: $doneAt, pickedAt: $pickedAt)';
}


}

/// @nodoc
abstract mixin class _$OrderModelCopyWith<$Res> implements $OrderModelCopyWith<$Res> {
  factory _$OrderModelCopyWith(_OrderModel value, $Res Function(_OrderModel) _then) = __$OrderModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'order_no') String orderNo,@JsonKey(name: 'cust_name') String? custName,@JsonKey(name: 'cust_phone') String? custPhone,@JsonKey(name: 'cust_address') String? custAddress, List<OrderItem> items,@JsonKey(name: 'duration_days') int durationDays, String status, int price, int discount,@JsonKey(name: 'is_paid') bool isPaid, String? notes,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'done_at') DateTime? doneAt,@JsonKey(name: 'picked_at') DateTime? pickedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderNo = null,Object? custName = freezed,Object? custPhone = freezed,Object? custAddress = freezed,Object? items = null,Object? durationDays = null,Object? status = null,Object? price = null,Object? discount = null,Object? isPaid = null,Object? notes = freezed,Object? createdAt = freezed,Object? doneAt = freezed,Object? pickedAt = freezed,}) {
  return _then(_OrderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderNo: null == orderNo ? _self.orderNo : orderNo // ignore: cast_nullable_to_non_nullable
as String,custName: freezed == custName ? _self.custName : custName // ignore: cast_nullable_to_non_nullable
as String?,custPhone: freezed == custPhone ? _self.custPhone : custPhone // ignore: cast_nullable_to_non_nullable
as String?,custAddress: freezed == custAddress ? _self.custAddress : custAddress // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
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
