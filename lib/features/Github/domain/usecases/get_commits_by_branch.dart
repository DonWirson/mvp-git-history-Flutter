import 'package:dartz/dartz.dart';
import 'package:git_history/core/use_case/use_case.dart';
import 'package:git_history/features/Github/domain/repositories/commit_repository.dart';

import '../../../../core/failures/failures.dart';
import '../entities/commit_history_entity.dart';

class GetCommitsByBranchUseCase
    implements UseCase<Either<Failure, List<CommitHistoryEntity>>, String> {
  final CommitRepository _commitRepository;

  GetCommitsByBranchUseCase(
    this._commitRepository,
  );

  @override
  Future<Either<Failure, List<CommitHistoryEntity>>> call({String? params}) {
    return _commitRepository.getCommitsByBranch(params ?? "");
  }
}
