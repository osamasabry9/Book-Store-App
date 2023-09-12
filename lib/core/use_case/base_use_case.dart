import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class BaseUseCase<Type, Parameters> {
  Future<Either<Failure, Type>> call(Parameters parameters);
}

class NoParameters {
}
