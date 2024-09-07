import 'package:freezed_annotation/freezed_annotation.dart';

part 'friends.freezed.dart';

@freezed
class Friends with _$Friends {
  const factory Friends({
    @Default([]) List<String> friends,
    @Default([]) List<String> requests,
  }) = _Friends;
}
