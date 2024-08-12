import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory.freezed.dart';

@freezed
class Memory with _$Memory {
  const factory Memory({
    required String id,
    required String userId,
    required GeoPoint location,
    required DateTime happenedAt,
    required DateTime updatedAt,
    required String title,
    required String contents,
    @Default([]) List<String> images,
  }) = _Memory;
}
