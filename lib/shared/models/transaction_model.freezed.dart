// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionModel {

 String get id; String get type;// 'income' or 'expense'
 int get amount;@JsonKey(name: 'category_id') String? get categoryId;@JsonKey(name: 'order_id') String? get orderId;@JsonKey(name: 'note') String? get description;@JsonKey(name: 'photo_url') String? get photoUrl;@JsonKey(name: 'payment_method') String? get paymentMethod;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<TransactionModel> get copyWith => _$TransactionModelCopyWithImpl<TransactionModel>(this as TransactionModel, _$identity);

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,categoryId,orderId,description,photoUrl,paymentMethod,createdAt);

@override
String toString() {
  return 'TransactionModel(id: $id, type: $type, amount: $amount, categoryId: $categoryId, orderId: $orderId, description: $description, photoUrl: $photoUrl, paymentMethod: $paymentMethod, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TransactionModelCopyWith<$Res>  {
  factory $TransactionModelCopyWith(TransactionModel value, $Res Function(TransactionModel) _then) = _$TransactionModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, int amount,@JsonKey(name: 'category_id') String? categoryId,@JsonKey(name: 'order_id') String? orderId,@JsonKey(name: 'note') String? description,@JsonKey(name: 'photo_url') String? photoUrl,@JsonKey(name: 'payment_method') String? paymentMethod,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$TransactionModelCopyWithImpl<$Res>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._self, this._then);

  final TransactionModel _self;
  final $Res Function(TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? categoryId = freezed,Object? orderId = freezed,Object? description = freezed,Object? photoUrl = freezed,Object? paymentMethod = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionModel].
extension TransactionModelPatterns on TransactionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _TransactionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  int amount, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(name: 'order_id')  String? orderId, @JsonKey(name: 'note')  String? description, @JsonKey(name: 'photo_url')  String? photoUrl, @JsonKey(name: 'payment_method')  String? paymentMethod, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.categoryId,_that.orderId,_that.description,_that.photoUrl,_that.paymentMethod,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  int amount, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(name: 'order_id')  String? orderId, @JsonKey(name: 'note')  String? description, @JsonKey(name: 'photo_url')  String? photoUrl, @JsonKey(name: 'payment_method')  String? paymentMethod, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _TransactionModel():
return $default(_that.id,_that.type,_that.amount,_that.categoryId,_that.orderId,_that.description,_that.photoUrl,_that.paymentMethod,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  int amount, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(name: 'order_id')  String? orderId, @JsonKey(name: 'note')  String? description, @JsonKey(name: 'photo_url')  String? photoUrl, @JsonKey(name: 'payment_method')  String? paymentMethod, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.categoryId,_that.orderId,_that.description,_that.photoUrl,_that.paymentMethod,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionModel implements TransactionModel {
  const _TransactionModel({required this.id, required this.type, required this.amount, @JsonKey(name: 'category_id') this.categoryId, @JsonKey(name: 'order_id') this.orderId, @JsonKey(name: 'note') this.description, @JsonKey(name: 'photo_url') this.photoUrl, @JsonKey(name: 'payment_method') this.paymentMethod, @JsonKey(name: 'created_at') required this.createdAt});
  factory _TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

@override final  String id;
@override final  String type;
// 'income' or 'expense'
@override final  int amount;
@override@JsonKey(name: 'category_id') final  String? categoryId;
@override@JsonKey(name: 'order_id') final  String? orderId;
@override@JsonKey(name: 'note') final  String? description;
@override@JsonKey(name: 'photo_url') final  String? photoUrl;
@override@JsonKey(name: 'payment_method') final  String? paymentMethod;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionModelCopyWith<_TransactionModel> get copyWith => __$TransactionModelCopyWithImpl<_TransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,categoryId,orderId,description,photoUrl,paymentMethod,createdAt);

@override
String toString() {
  return 'TransactionModel(id: $id, type: $type, amount: $amount, categoryId: $categoryId, orderId: $orderId, description: $description, photoUrl: $photoUrl, paymentMethod: $paymentMethod, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TransactionModelCopyWith<$Res> implements $TransactionModelCopyWith<$Res> {
  factory _$TransactionModelCopyWith(_TransactionModel value, $Res Function(_TransactionModel) _then) = __$TransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, int amount,@JsonKey(name: 'category_id') String? categoryId,@JsonKey(name: 'order_id') String? orderId,@JsonKey(name: 'note') String? description,@JsonKey(name: 'photo_url') String? photoUrl,@JsonKey(name: 'payment_method') String? paymentMethod,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$TransactionModelCopyWithImpl<$Res>
    implements _$TransactionModelCopyWith<$Res> {
  __$TransactionModelCopyWithImpl(this._self, this._then);

  final _TransactionModel _self;
  final $Res Function(_TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? categoryId = freezed,Object? orderId = freezed,Object? description = freezed,Object? photoUrl = freezed,Object? paymentMethod = freezed,Object? createdAt = null,}) {
  return _then(_TransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
