// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
      phoneNumber: json['phoneNumber'] as String,
      bookingSubmissionAt: const TimestampConverter()
          .fromJson(json['bookingSubmissionAt'] as Timestamp),
      bookedGameDateTime: const TimestampConverter()
          .fromJson(json['bookedGameDateTime'] as Timestamp),
      gameState: $enumDecode(_$GameStateEnumMap, json['gameState']),
      currentPuzzleId: (json['currentPuzzleId'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'bookingSubmissionAt':
          const TimestampConverter().toJson(instance.bookingSubmissionAt),
      'bookedGameDateTime':
          const TimestampConverter().toJson(instance.bookedGameDateTime),
      'gameState': _$GameStateEnumMap[instance.gameState]!,
      'currentPuzzleId': instance.currentPuzzleId,
    };

const _$GameStateEnumMap = {
  GameState.gameBooked: 'gameBooked',
  GameState.verified: 'verified',
  GameState.notVerified: 'notVerified',
  GameState.noShow: 'noShow',
  GameState.playing: 'playing',
  GameState.finished: 'finished',
  GameState.canceled: 'canceled',
  GameState.abandoned: 'abandoned',
};
