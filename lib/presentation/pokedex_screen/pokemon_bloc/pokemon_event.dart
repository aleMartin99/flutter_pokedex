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
