part of 'pokemon_bloc.dart';

///Pokemon base Event class
sealed class PokemonEvent extends Equatable {}

///OnLoadPokemonsEvent class
class OnLoadPokemonsEvent extends PokemonEvent {
  ///
  OnLoadPokemonsEvent({
    this.offset = 0,
    this.limit = 20,
  });

  /// The offset for pagination
  final int offset;

  /// The number of pokemons to fetch
  final int limit;

  @override
  List<Object> get props => [offset, limit];
}

///OnLoadMorePokemonsEvent class - Loads more pokemons for pagination
class OnLoadMorePokemonsEvent extends PokemonEvent {
  ///
  OnLoadMorePokemonsEvent({
    required this.offset,
    this.limit = 20,
  });

  /// The offset for pagination
  final int offset;

  /// The number of pokemons to fetch
  final int limit;

  @override
  List<Object> get props => [offset, limit];
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
