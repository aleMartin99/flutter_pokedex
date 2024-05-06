// ignore_for_file: unnecessary_await_in_return, avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';

import 'package:flutter_pokedex/core/constants/api_helper.dart';
import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/data/datasources/remote_datasource/remote_datasource_exports.dart';
import 'package:flutter_pokedex/data/models/remote_models/remote_models_exports.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

/// PokemonDatasource implementation
class PokemonDatasource implements IPokemonDatasource {
  @override
  Future<Either<Failure, List<PokemonModel>>> getPokemons() async {
    /// get the 151 pokemos
    final resultFetchPokemonList = await fetchPokemonList();
    final pokemonModelListAux = <PokemonModel>[];

    if (resultFetchPokemonList.isRight()) {
      final resultFetchPokemonDetailsSubset = await fetchPokemonDetailsSubset(
        ((resultFetchPokemonList as Right).value as List<dynamic>)
            .sublist(0, 48),
      );
      if (resultFetchPokemonDetailsSubset.isRight()) {
        pokemonModelListAux.addAll(
          (resultFetchPokemonDetailsSubset as Right).value
              as List<PokemonModel>,
        );
        final a = await fetchPokemonDetailsSubset(
          ((resultFetchPokemonList as Right).value as List<dynamic>)
              .sublist(49, 95),
        );

        if (a.isRight()) {
          pokemonModelListAux.addAll((a as Right).value as List<PokemonModel>);
          final b = await fetchPokemonDetailsSubset(
            ((resultFetchPokemonList as Right).value as List<dynamic>)
                .sublist(96, 151),
          );
          if (b.isRight()) {
            pokemonModelListAux
                .addAll((b as Right).value as List<PokemonModel>);
            return right(
              pokemonModelListAux,
            );
          } else {
            return left(const UnexpectedFailure());
          }
        } else {
          return left(const UnexpectedFailure());
        }
      } else {
        return left(const UnexpectedFailure());
      }
    } else {
      return left(const UnexpectedFailure());
    }
  }
}

/// Fetches the list of Pokémon
Future<Either<Failure, List<dynamic>>> fetchPokemonList() async {
  try {
    final response = await http.get(
      Uri.parse(
        ApiHelper.baseUrl + ApiHelper.getPokemonsUrl,
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return right(data['results'] as List<dynamic>);
    } else {
      throw Exception('Failed to load initial Pokémon list');
    }
  } catch (e) {
    return left(UnexpectedFailure(message: e.toString()));
  }
}

/// Fetches details for a single Pokémon
Future<Either<Failure, Map<String, dynamic>>> fetchPokemonDetails(
  String url,
) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return right(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      return left(const ServerFailure());
    }
  } catch (e) {
    return left(UnexpectedFailure(message: e.toString()));
  }
}

/// Fetches details for a subset of Pokémon
Future<Either<Failure, List<PokemonModel>>> fetchPokemonDetailsSubset(
  List<dynamic> pokemonSubset,
) async {
  try {
    final futureDetails = pokemonSubset.map((pokemon) {
      return fetchPokemonDetails(pokemon['url'] as String);
    }).toList();

    return right(
      (await Future.wait(
        futureDetails,
      ))
          .map((pokemon) {
        if (pokemon.isRight()) {
          return PokemonModel.fromJson(
            (pokemon as Right).value as Map<String, dynamic>,
          );
        } else {
          throw Exception();
        }
      }).toList(),
    );
  } catch (e) {
    return left(UnexpectedFailure(message: e.toString()));
  }
}
