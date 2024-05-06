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

///
class OnLoadCapturedPokemonsEvent extends PokemonEvent {
  ///
  OnLoadCapturedPokemonsEvent();

  @override
  List<Object> get props => [];
}

///OnToggleCapturedPokemonEvent class
class OnToggleCapturedPokemonEvent extends PokemonEvent {
  ///
  OnToggleCapturedPokemonEvent({
    required this.capturedPokemon,
    required this.isCaptured,
  });

  /// captured pokemon .
  final Pokemon capturedPokemon;

  /// Captured state to toggle.
  final bool isCaptured;

  @override
  List<Object> get props => [capturedPokemon, isCaptured];
}
