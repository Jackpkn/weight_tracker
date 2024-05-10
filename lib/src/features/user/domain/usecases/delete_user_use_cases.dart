import 'package:fpdart/fpdart.dart';

import '../../../../app_exports.dart';

class DeleteUserUseCase implements UseCase<void, String> {
  final UserRepository repository;

  DeleteUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String username) async {
    return repository.deleteUser(username);
  }
}
