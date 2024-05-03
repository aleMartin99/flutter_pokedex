part of 'pokemon_bloc.dart';

///Pokemon base Event class
sealed class PokemonEvent extends Equatable {}

///OnLoadPokemonsEvent class
class OnLoadPokemonsEvent extends PokemonEvent {
  ///
  OnLoadPokemonsEvent();

  @override
  List<Object> get props => [];
}

///OnToggleCapturedPokemonEvent class
class OnToggleCapturedPokemonEvent extends PokemonEvent {
  ///
  OnToggleCapturedPokemonEvent({
    required this.capturedPokemonId,
    required this.isCaptured,
  });

  /// captured pokemon id.
  final String capturedPokemonId;

  /// Captured state to toggle.
  final bool isCaptured;

  @override
  List<Object> get props => [capturedPokemonId, isCaptured];
}
