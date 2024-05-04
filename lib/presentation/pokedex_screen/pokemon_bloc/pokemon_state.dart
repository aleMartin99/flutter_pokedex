part of 'pokemon_bloc.dart';

/// PokemonState class
class PokemonState extends Equatable {
  ///
  const PokemonState({
    this.status = PokemonStatus.initial,
    this.pokemonsList = const [],
    this.capturedPokemonsList = const [],
    this.failure,
  });

  /// PokemonState status
  final PokemonStatus status;

  /// PokemonState pokemonsList
  final List<Pokemon> pokemonsList;

  /// PokemonState pokemonsCapturedList
  final List<Pokemon> capturedPokemonsList;

  /// PokemonState failure
  final String? failure;

  @override
  List<Object?> get props => [
        status,
        pokemonsList,
        capturedPokemonsList,
        failure,
      ];

  /// PokemonState copyWith method
  PokemonState copyWith({
    PokemonStatus? status,
    List<Pokemon>? pokemonsList,
    List<Pokemon>? capturedPokemonsList,
    String? failure,
  }) {
    return PokemonState(
      status: status ?? this.status,
      pokemonsList: pokemonsList ?? this.pokemonsList,
      capturedPokemonsList: capturedPokemonsList ?? this.capturedPokemonsList,
      failure: failure ?? this.failure,
    );
  }
}
