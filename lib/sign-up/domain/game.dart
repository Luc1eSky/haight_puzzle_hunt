import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonEnum()
enum GameState {
  gameBooked,
  verified,
  started,
  inProgress,
  finished,
  canceled,
  abandoned,
}

@freezed
class Game with _$Game {
  // const Game._();
  const factory Game({
    required String phoneNumber,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime bookedDateTime,
    required GameState gameState,
  }) = _Game;

  factory Game.fromJson(Map<String, Object?> json) => _$GameFromJson(json);
}
