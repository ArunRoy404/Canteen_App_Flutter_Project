import 'package:canteen_app/core/error/exception.dart';
import 'package:canteen_app/core/error/failure.dart';
import 'package:canteen_app/features/data/data_resources/auth_remote_data_source.dart';
import 'package:canteen_app/features/domain/Repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remotedataSource;
  const AuthRepositoryImpl(this.remotedataSource);

  @override
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userID = await remotedataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userID);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
