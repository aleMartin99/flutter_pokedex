// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

/// Generic class for Use cases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
