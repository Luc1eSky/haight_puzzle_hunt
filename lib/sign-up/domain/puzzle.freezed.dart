// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'puzzle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Puzzle _$PuzzleFromJson(Map<String, dynamic> json) {
  return _Puzzle.fromJson(json);
}

/// @nodoc
mixin _$Puzzle {
  String get gameId => throw _privateConstructorUsedError;
  int get puzzleId => throw _privateConstructorUsedError;
  bool get inProgress => throw _privateConstructorUsedError;
  int get hintsUsed => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get startedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this Puzzle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Puzzle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PuzzleCopyWith<Puzzle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PuzzleCopyWith<$Res> {
  factory $PuzzleCopyWith(Puzzle value, $Res Function(Puzzle) then) =
      _$PuzzleCopyWithImpl<$Res, Puzzle>;
  @useResult
  $Res call(
      {String gameId,
      int puzzleId,
      bool inProgress,
      int hintsUsed,
      @TimestampConverter() DateTime startedAt,
      @TimestampConverter() DateTime? completedAt});
}

/// @nodoc
class _$PuzzleCopyWithImpl<$Res, $Val extends Puzzle>
    implements $PuzzleCopyWith<$Res> {
  _$PuzzleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Puzzle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? puzzleId = null,
    Object? inProgress = null,
    Object? hintsUsed = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      puzzleId: null == puzzleId
          ? _value.puzzleId
          : puzzleId // ignore: cast_nullable_to_non_nullable
              as int,
      inProgress: null == inProgress
          ? _value.inProgress
          : inProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      hintsUsed: null == hintsUsed
          ? _value.hintsUsed
          : hintsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PuzzleImplCopyWith<$Res> implements $PuzzleCopyWith<$Res> {
  factory _$$PuzzleImplCopyWith(
          _$PuzzleImpl value, $Res Function(_$PuzzleImpl) then) =
      __$$PuzzleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String gameId,
      int puzzleId,
      bool inProgress,
      int hintsUsed,
      @TimestampConverter() DateTime startedAt,
      @TimestampConverter() DateTime? completedAt});
}

/// @nodoc
class __$$PuzzleImplCopyWithImpl<$Res>
    extends _$PuzzleCopyWithImpl<$Res, _$PuzzleImpl>
    implements _$$PuzzleImplCopyWith<$Res> {
  __$$PuzzleImplCopyWithImpl(
      _$PuzzleImpl _value, $Res Function(_$PuzzleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Puzzle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? puzzleId = null,
    Object? inProgress = null,
    Object? hintsUsed = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(_$PuzzleImpl(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      puzzleId: null == puzzleId
          ? _value.puzzleId
          : puzzleId // ignore: cast_nullable_to_non_nullable
              as int,
      inProgress: null == inProgress
          ? _value.inProgress
          : inProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      hintsUsed: null == hintsUsed
          ? _value.hintsUsed
          : hintsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PuzzleImpl implements _Puzzle {
  const _$PuzzleImpl(
      {required this.gameId,
      required this.puzzleId,
      required this.inProgress,
      this.hintsUsed = 0,
      @TimestampConverter() required this.startedAt,
      @TimestampConverter() this.completedAt});

  factory _$PuzzleImpl.fromJson(Map<String, dynamic> json) =>
      _$$PuzzleImplFromJson(json);

  @override
  final String gameId;
  @override
  final int puzzleId;
  @override
  final bool inProgress;
  @override
  @JsonKey()
  final int hintsUsed;
  @override
  @TimestampConverter()
  final DateTime startedAt;
  @override
  @TimestampConverter()
  final DateTime? completedAt;

  @override
  String toString() {
    return 'Puzzle(gameId: $gameId, puzzleId: $puzzleId, inProgress: $inProgress, hintsUsed: $hintsUsed, startedAt: $startedAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PuzzleImpl &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.puzzleId, puzzleId) ||
                other.puzzleId == puzzleId) &&
            (identical(other.inProgress, inProgress) ||
                other.inProgress == inProgress) &&
            (identical(other.hintsUsed, hintsUsed) ||
                other.hintsUsed == hintsUsed) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, gameId, puzzleId, inProgress,
      hintsUsed, startedAt, completedAt);

  /// Create a copy of Puzzle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PuzzleImplCopyWith<_$PuzzleImpl> get copyWith =>
      __$$PuzzleImplCopyWithImpl<_$PuzzleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PuzzleImplToJson(
      this,
    );
  }
}

abstract class _Puzzle implements Puzzle {
  const factory _Puzzle(
      {required final String gameId,
      required final int puzzleId,
      required final bool inProgress,
      final int hintsUsed,
      @TimestampConverter() required final DateTime startedAt,
      @TimestampConverter() final DateTime? completedAt}) = _$PuzzleImpl;

  factory _Puzzle.fromJson(Map<String, dynamic> json) = _$PuzzleImpl.fromJson;

  @override
  String get gameId;
  @override
  int get puzzleId;
  @override
  bool get inProgress;
  @override
  int get hintsUsed;
  @override
  @TimestampConverter()
  DateTime get startedAt;
  @override
  @TimestampConverter()
  DateTime? get completedAt;

  /// Create a copy of Puzzle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PuzzleImplCopyWith<_$PuzzleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
