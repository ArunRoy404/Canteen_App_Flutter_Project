import 'package:canteen_app/core/error/failure.dart';
import 'package:canteen_app/core/usecase/usecase.dart';
import 'package:canteen_app/features/domain/Repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
