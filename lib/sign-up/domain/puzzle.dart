import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'puzzle.freezed.dart';
part 'puzzle.g.dart';

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? date) =>
      date == null ? null : Timestamp.fromDate(date);
}

@freezed
class Puzzle with _$Puzzle {
  const factory Puzzle({
    required String gameId,
    required int puzzleId,
    required bool inProgress,
    @Default(0) int hintsUsed,
    @TimestampConverter() required DateTime startedAt,
    @TimestampConverter() DateTime? completedAt, // optional
  }) = _Puzzle;

  factory Puzzle.fromJson(Map<String, Object?> json) => _$PuzzleFromJson(json);
}
