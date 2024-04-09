import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/confirm_delivery/data/modules/confirm_delivery.dart';
import 'package:nishauri/src/features/confirm_delivery/data/repository/confirm_delivery_repository.dart';

class ConfirmDeliveryController extends StateNotifier<AsyncValue<List<ConfirmDelivery>>> {
  final ConfirmDeliveryRepository _repository;

  ConfirmDeliveryController(this._repository) : super(const AsyncValue.loading()){
  }
  Future<String> confirmDelivery(Map<String, dynamic> data) async {
    try{
      final confirmation = await _repository.confirmDelivery(data);
      return confirmation;
    }catch (e){
      rethrow;
    }
  }
  }