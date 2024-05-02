part of 'pokemon_bloc.dart';

/// PokemonState class
class PokemonState extends Equatable {
  ///
  const PokemonState({
    this.status = PokemonStatus.initial,
    this.pokemonsList = const [],
    this.failure,
  });

  /// PokemonState status
  final PokemonStatus status;

  /// PokemonState radioStationsList
  final List<Pokemon> pokemonsList;

  /// PokemonState failure
  final String? failure;

  @override
  List<Object?> get props => [status, pokemonsList, failure];

  /// PokemonState copyWith method
  PokemonState copyWith({
    PokemonStatus? status,
    List<Pokemon>? pokemonsList,
    String? failure,
  }) {
    return PokemonState(
      status: status ?? this.status,
      pokemonsList: pokemonsList ?? this.pokemonsList,
      failure: failure ?? this.failure,
    );
  }
}
