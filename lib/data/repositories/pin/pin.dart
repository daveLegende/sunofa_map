import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/sources/pin/pin.service.dart';
import 'package:sunofa_map/domain/repositories/pin/pin_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class PinRepositoryImpl extends PinRepository {
  @override
  Future<Either> sendPin() async {
    return await sl<PinService>().sendPin();
  }
  @override
  Future<Either> requestPin() async {
    return await sl<PinService>().requestPin();
  }
}
