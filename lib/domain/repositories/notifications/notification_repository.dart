import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/id.dto.dart';

abstract class NotificationRepository {
  Future<Either> requestPin(IdParms data);
  Future<Either> sendPin(IdParms data);
  Future<Either> validatePin(FullPin data);
}