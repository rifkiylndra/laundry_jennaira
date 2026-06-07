// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InventoryModel {

 String get id; String get name; String get unit; double get stock; double get minStock;@JsonKey(name: 'cost_per_unit') int get costPerUnit;
/// Create a copy of InventoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InventoryModelCopyWith<InventoryModel> get copyWith => _$InventoryModelCopyWithImpl<InventoryModel>(this as InventoryModel, _$identity);

  /// Serializes this InventoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InventoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.minStock, minStock) || other.minStock == minStock)&&(identical(other.costPerUnit, costPerUnit) || other.costPerUnit == costPerUnit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,unit,stock,minStock,costPerUnit);

@override
String toString() {
  return 'InventoryModel(id: $id, name: $name, unit: $unit, stock: $stock, minStock: $minStock, costPerUnit: $costPerUnit)';
}


}

/// @nodoc
abstract mixin class $InventoryModelCopyWith<$Res>  {
  factory $InventoryModelCopyWith(InventoryModel value, $Res Function(InventoryModel) _then) = _$InventoryModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String unit, double stock, double minStock,@JsonKey(name: 'cost_per_unit') int costPerUnit
});




}
/// @nodoc
class _$InventoryModelCopyWithImpl<$Res>
    implements $InventoryModelCopyWith<$Res> {
  _$InventoryModelCopyWithImpl(this._self, this._then);

  final InventoryModel _self;
  final $Res Function(InventoryModel) _then;

/// Create a copy of InventoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? unit = null,Object? stock = null,Object? minStock = null,Object? costPerUnit = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as double,minStock: null == minStock ? _self.minStock : minStock // ignore: cast_nullable_to_non_nullable
as double,costPerUnit: null == costPerUnit ? _self.costPerUnit : costPerUnit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InventoryModel].
extension InventoryModelPatterns on InventoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InventoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InventoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InventoryModel value)  $default,){
final _that = this;
switch (_that) {
case _InventoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InventoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _InventoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String unit,  double stock,  double minStock, @JsonKey(name: 'cost_per_unit')  int costPerUnit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InventoryModel() when $default != null:
return $default(_that.id,_that.name,_that.unit,_that.stock,_that.minStock,_that.costPerUnit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String unit,  double stock,  double minStock, @JsonKey(name: 'cost_per_unit')  int costPerUnit)  $default,) {final _that = this;
switch (_that) {
case _InventoryModel():
return $default(_that.id,_that.name,_that.unit,_that.stock,_that.minStock,_that.costPerUnit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String unit,  double stock,  double minStock, @JsonKey(name: 'cost_per_unit')  int costPerUnit)?  $default,) {final _that = this;
switch (_that) {
case _InventoryModel() when $default != null:
return $default(_that.id,_that.name,_that.unit,_that.stock,_that.minStock,_that.costPerUnit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InventoryModel implements InventoryModel {
   _InventoryModel({required this.id, required this.name, required this.unit, this.stock = 0.0, this.minStock = 1.0, @JsonKey(name: 'cost_per_unit') this.costPerUnit = 0});
  factory _InventoryModel.fromJson(Map<String, dynamic> json) => _$InventoryModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String unit;
@override@JsonKey() final  double stock;
@override@JsonKey() final  double minStock;
@override@JsonKey(name: 'cost_per_unit') final  int costPerUnit;

/// Create a copy of InventoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InventoryModelCopyWith<_InventoryModel> get copyWith => __$InventoryModelCopyWithImpl<_InventoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InventoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InventoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.minStock, minStock) || other.minStock == minStock)&&(identical(other.costPerUnit, costPerUnit) || other.costPerUnit == costPerUnit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,unit,stock,minStock,costPerUnit);

@override
String toString() {
  return 'InventoryModel(id: $id, name: $name, unit: $unit, stock: $stock, minStock: $minStock, costPerUnit: $costPerUnit)';
}


}

/// @nodoc
abstract mixin class _$InventoryModelCopyWith<$Res> implements $InventoryModelCopyWith<$Res> {
  factory _$InventoryModelCopyWith(_InventoryModel value, $Res Function(_InventoryModel) _then) = __$InventoryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String unit, double stock, double minStock,@JsonKey(name: 'cost_per_unit') int costPerUnit
});




}
/// @nodoc
class __$InventoryModelCopyWithImpl<$Res>
    implements _$InventoryModelCopyWith<$Res> {
  __$InventoryModelCopyWithImpl(this._self, this._then);

  final _InventoryModel _self;
  final $Res Function(_InventoryModel) _then;

/// Create a copy of InventoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? unit = null,Object? stock = null,Object? minStock = null,Object? costPerUnit = null,}) {
  return _then(_InventoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as double,minStock: null == minStock ? _self.minStock : minStock // ignore: cast_nullable_to_non_nullable
as double,costPerUnit: null == costPerUnit ? _self.costPerUnit : costPerUnit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
