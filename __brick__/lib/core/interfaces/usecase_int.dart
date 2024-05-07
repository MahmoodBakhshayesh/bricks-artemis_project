import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'failures_int.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params request});
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}