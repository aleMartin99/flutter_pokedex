part of 'evolution_chain_bloc.dart';

///EvolutionChain base Event class
sealed class EvolutionChainEvent extends Equatable {}

///OnLoadEvolutionChainEvent class
class OnLoadEvolutionChainEvent extends EvolutionChainEvent {
  ///
  OnLoadEvolutionChainEvent({required this.pokemonId});

  /// The Pokemon ID to get evolution chain for
  final int pokemonId;

  @override
  List<Object> get props => [pokemonId];
}

