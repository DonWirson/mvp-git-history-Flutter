import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_history/features/Github/presentation/widgets/all_commits_page/all_commits_failure.dart';
import '../widgets/all_commits_page/all_commits_successfull.dart';
import 'package:intl/intl.dart';

import '../../../../core/loading_indicator.dart';
import '../../data/models/commit_model.dart';
import '../bloc/github_bloc.dart';

class AllCommitsPage extends StatefulWidget {
  const AllCommitsPage({super.key});

  @override
  State<AllCommitsPage> createState() => _AllCommitsPageState();
}

class _AllCommitsPageState extends State<AllCommitsPage> {
  List<CommitModel> commitList = [];
  @override
  void initState() {
    BlocProvider.of<GithubBloc>(context).add(GotAllCommits());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GithubBloc, GithubState>(
      listener: (context, state) {
        if (state is GotAllCommitsSuccessfully) {
          commitList = state.commits;
        }
      },
      builder: (context, state) {
        if (state is GotAllCommitsSuccessfully) {
          return AllCommitsSuccessfull(
            commitList: commitList,
          );
        }
        if (state is GotAllCommitsFailure) {
          return const AllCommitsFailure();
        }
        return const LoadingIndicator(); //Default state is the loading spinner :D
      },
    );
  }

  Future<void> onRefresh() async {
    BlocProvider.of<GithubBloc>(context).add(GotAllCommits());
  }
}
