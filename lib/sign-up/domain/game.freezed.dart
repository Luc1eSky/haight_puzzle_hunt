// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
mixin _$Game {
  String get phoneNumber => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get bookingSubmissionAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get bookedGameDateTime => throw _privateConstructorUsedError;
  GameState get gameState => throw _privateConstructorUsedError;
  int get currentPuzzleId => throw _privateConstructorUsedError;

  /// Serializes this Game to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call(
      {String phoneNumber,
      @TimestampConverter() DateTime bookingSubmissionAt,
      @TimestampConverter() DateTime bookedGameDateTime,
      GameState gameState,
      int currentPuzzleId});
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? bookingSubmissionAt = null,
    Object? bookedGameDateTime = null,
    Object? gameState = null,
    Object? currentPuzzleId = null,
  }) {
    return _then(_value.copyWith(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      bookingSubmissionAt: null == bookingSubmissionAt
          ? _value.bookingSubmissionAt
          : bookingSubmissionAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bookedGameDateTime: null == bookedGameDateTime
          ? _value.bookedGameDateTime
          : bookedGameDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gameState: null == gameState
          ? _value.gameState
          : gameState // ignore: cast_nullable_to_non_nullable
              as GameState,
      currentPuzzleId: null == currentPuzzleId
          ? _value.currentPuzzleId
          : currentPuzzleId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
          _$GameImpl value, $Res Function(_$GameImpl) then) =
      __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String phoneNumber,
      @TimestampConverter() DateTime bookingSubmissionAt,
      @TimestampConverter() DateTime bookedGameDateTime,
      GameState gameState,
      int currentPuzzleId});
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
      : super(_value, _then);

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? bookingSubmissionAt = null,
    Object? bookedGameDateTime = null,
    Object? gameState = null,
    Object? currentPuzzleId = null,
  }) {
    return _then(_$GameImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      bookingSubmissionAt: null == bookingSubmissionAt
          ? _value.bookingSubmissionAt
          : bookingSubmissionAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bookedGameDateTime: null == bookedGameDateTime
          ? _value.bookedGameDateTime
          : bookedGameDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gameState: null == gameState
          ? _value.gameState
          : gameState // ignore: cast_nullable_to_non_nullable
              as GameState,
      currentPuzzleId: null == currentPuzzleId
          ? _value.currentPuzzleId
          : currentPuzzleId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameImpl implements _Game {
  const _$GameImpl(
      {required this.phoneNumber,
      @TimestampConverter() required this.bookingSubmissionAt,
      @TimestampConverter() required this.bookedGameDateTime,
      required this.gameState,
      this.currentPuzzleId = 0});

  factory _$GameImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameImplFromJson(json);

  @override
  final String phoneNumber;
  @override
  @TimestampConverter()
  final DateTime bookingSubmissionAt;
  @override
  @TimestampConverter()
  final DateTime bookedGameDateTime;
  @override
  final GameState gameState;
  @override
  @JsonKey()
  final int currentPuzzleId;

  @override
  String toString() {
    return 'Game(phoneNumber: $phoneNumber, bookingSubmissionAt: $bookingSubmissionAt, bookedGameDateTime: $bookedGameDateTime, gameState: $gameState, currentPuzzleId: $currentPuzzleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.bookingSubmissionAt, bookingSubmissionAt) ||
                other.bookingSubmissionAt == bookingSubmissionAt) &&
            (identical(other.bookedGameDateTime, bookedGameDateTime) ||
                other.bookedGameDateTime == bookedGameDateTime) &&
            (identical(other.gameState, gameState) ||
                other.gameState == gameState) &&
            (identical(other.currentPuzzleId, currentPuzzleId) ||
                other.currentPuzzleId == currentPuzzleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber, bookingSubmissionAt,
      bookedGameDateTime, gameState, currentPuzzleId);

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameImplToJson(
      this,
    );
  }
}

abstract class _Game implements Game {
  const factory _Game(
      {required final String phoneNumber,
      @TimestampConverter() required final DateTime bookingSubmissionAt,
      @TimestampConverter() required final DateTime bookedGameDateTime,
      required final GameState gameState,
      final int currentPuzzleId}) = _$GameImpl;

  factory _Game.fromJson(Map<String, dynamic> json) = _$GameImpl.fromJson;

  @override
  String get phoneNumber;
  @override
  @TimestampConverter()
  DateTime get bookingSubmissionAt;
  @override
  @TimestampConverter()
  DateTime get bookedGameDateTime;
  @override
  GameState get gameState;
  @override
  int get currentPuzzleId;

  /// Create a copy of Game
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
