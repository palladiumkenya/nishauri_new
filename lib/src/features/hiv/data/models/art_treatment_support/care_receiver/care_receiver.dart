import 'package:freezed_annotation/freezed_annotation.dart';
part 'care_receiver.freezed.dart';
part 'care_receiver.g.dart';

@Freezed()
class CareReceiver with _$CareReceiver {
  const factory CareReceiver({
    required String cccNumber,
    required String name,
    String? phoneNumber,

  }) = _CareReceiver;

  factory CareReceiver.fromJson(Map<String, dynamic> json)=> _$CareReceiverFromJson(json);
}