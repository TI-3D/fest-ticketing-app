abstract class UseCase<Type,Params> {
  Future<Type> call(Params params);
}

abstract class UseCaseNoParams<Type> {
  Future<Type> call();
}

abstract class StreamUseCase<Type,Params> {
  Stream<Type> call(Params params);
}

abstract class StreamUseCaseNoParams<Type> {
  Stream<Type> call();
}