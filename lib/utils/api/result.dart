sealed class Result<S, E extends String> {
  const Result();
}

final class Success<S, E extends String> extends Result<S, E> {
  const Success(this.value);

  final S value;
}

final class Failure<S, E extends String> extends Result<S, E> {
  const Failure(this.exception);

  final E exception;
}
