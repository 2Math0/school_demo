part of 'progress_cubit.dart';

abstract class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object?> get props => [];
}

class ProgressInitial extends ProgressState {
  const ProgressInitial();
}

class ProgressLoading extends ProgressState {
  const ProgressLoading();
}

class ProgressLoaded extends ProgressState {
  final Progress progress;

  const ProgressLoaded({required this.progress});

  @override
  List<Object?> get props => [progress];
}

class OverallProgressLoaded extends ProgressState {
  final Map<String, dynamic> stats;

  const OverallProgressLoaded({required this.stats});

  @override
  List<Object?> get props => [stats];
}

class ProgressError extends ProgressState {
  final String message;

  const ProgressError({required this.message});

  @override
  List<Object?> get props => [message];
}
