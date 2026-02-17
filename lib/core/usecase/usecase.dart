import 'package:clen_archetecture_bloc_app/core/error/faliure.dart';
import 'package:fpdart/fpdart.dart';

//interface for usecase
abstract interface class Usecase<SuccsussType, Parms> {
  Future<Either<Faliure, SuccsussType>> call(Parms parms);
}
