import 'package:dartz/dartz.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/data/sources/notifications/notification.dart';
import 'package:sunofa_map/domain/repositories/notifications/notification_repository.dart';
import 'package:sunofa_map/service_locator.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  
  @override
  Future<Either> requestPin(IdParms data) async {
    return await sl<NotificationService>().requestPin(data);
  }
  
  @override
  Future<Either> sendPin(IdParms data) async {
    return await sl<NotificationService>().sendPin(data);
  }
  
  @override
  Future<Either> validatePin(FullPin data) async {
    return await sl<NotificationService>().validatePin(data);
  }
}
