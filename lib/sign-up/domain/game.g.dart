// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
      phoneNumber: json['phoneNumber'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      bookedDateTime: const TimestampConverter()
          .fromJson(json['bookedDateTime'] as Timestamp),
      gameState: $enumDecode(_$GameStateEnumMap, json['gameState']),
    );

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'bookedDateTime':
          const TimestampConverter().toJson(instance.bookedDateTime),
      'gameState': _$GameStateEnumMap[instance.gameState]!,
    };

const _$GameStateEnumMap = {
  GameState.gameBooked: 'gameBooked',
  GameState.verified: 'verified',
  GameState.started: 'started',
  GameState.inProgress: 'inProgress',
  GameState.finished: 'finished',
  GameState.canceled: 'canceled',
  GameState.abandoned: 'abandoned',
};
