part of 'pokemon_bloc.dart';

/// PokemonState class
class PokemonState extends Equatable {
  ///
  const PokemonState({
    this.status = PokemonStatus.initial,
    this.pokemonsList = const [],
    this.capturedPokemonsList = const [],
    this.failure,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  /// PokemonState status
  final PokemonStatus status;

  /// PokemonState pokemonsList
  final List<Pokemon> pokemonsList;

  /// PokemonState pokemonsCapturedList
  final List<Pokemon> capturedPokemonsList;

  /// PokemonState failure
  final String? failure;

  /// Indicates if all pokemons have been loaded
  final bool hasReachedMax;

  /// Indicates if more pokemons are being loaded
  final bool isLoadingMore;

  @override
  List<Object?> get props => [
        status,
        pokemonsList,
        capturedPokemonsList,
        failure,
        hasReachedMax,
        isLoadingMore,
      ];

  /// PokemonState copyWith method
  PokemonState copyWith({
    PokemonStatus? status,
    List<Pokemon>? pokemonsList,
    List<Pokemon>? capturedPokemonsList,
    String? failure,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return PokemonState(
      status: status ?? this.status,
      pokemonsList: pokemonsList ?? this.pokemonsList,
      capturedPokemonsList: capturedPokemonsList ?? this.capturedPokemonsList,
      failure: failure ?? this.failure,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
