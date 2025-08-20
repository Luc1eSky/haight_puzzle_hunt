// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'puzzle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PuzzleImpl _$$PuzzleImplFromJson(Map<String, dynamic> json) => _$PuzzleImpl(
      gameId: json['gameId'] as String,
      puzzleId: (json['puzzleId'] as num).toInt(),
      inProgress: json['inProgress'] as bool,
      hintsUsed: (json['hintsUsed'] as num?)?.toInt() ?? 0,
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: const TimestampConverter()
          .fromJson(json['completedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$PuzzleImplToJson(_$PuzzleImpl instance) =>
    <String, dynamic>{
      'gameId': instance.gameId,
      'puzzleId': instance.puzzleId,
      'inProgress': instance.inProgress,
      'hintsUsed': instance.hintsUsed,
      'startedAt': instance.startedAt.toIso8601String(),
      'completedAt': const TimestampConverter().toJson(instance.completedAt),
    };
