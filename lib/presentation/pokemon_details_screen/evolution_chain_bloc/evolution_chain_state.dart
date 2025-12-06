part of 'evolution_chain_bloc.dart';

/// EvolutionChainState class
class EvolutionChainState extends Equatable {
  ///
  const EvolutionChainState({
    this.status = EvolutionChainStatus.initial,
    this.evolutionChain,
    this.failure,
  });

  /// EvolutionChainState status
  final EvolutionChainStatus status;

  /// EvolutionChainState evolutionChain
  final EvolutionChainModel? evolutionChain;

  /// EvolutionChainState failure
  final String? failure;

  @override
  List<Object?> get props => [
        status,
        evolutionChain,
        failure,
      ];

  /// EvolutionChainState copyWith method
  EvolutionChainState copyWith({
    EvolutionChainStatus? status,
    EvolutionChainModel? evolutionChain,
    String? failure,
  }) {
    return EvolutionChainState(
      status: status ?? this.status,
      evolutionChain: evolutionChain ?? this.evolutionChain,
      failure: failure ?? this.failure,
    );
  }
}

