import 'package:dartz/dartz.dart';

abstract class PinRepository {
  Future<Either> sendPin();
  Future<Either> requestPin();
}