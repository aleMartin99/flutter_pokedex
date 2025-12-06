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
  Future<Either<Failure, List<PokemonModel>>> getPokemons({
    int offset = 0,
    int limit = 20,
  }) async {
    final resultFetchPokemonList = await fetchPokemonList(
      offset: offset,
      limit: limit,
    );

    if (resultFetchPokemonList.isLeft()) {
      return left((resultFetchPokemonList as Left).value as Failure);
    }

    final pokemonList =
        (resultFetchPokemonList as Right).value as List<dynamic>;

    if (pokemonList.isEmpty) {
      return right(<PokemonModel>[]);
    }

    final resultFetchPokemonDetails = await fetchPokemonDetailsSubset(
      pokemonList,
    );

    if (resultFetchPokemonDetails.isLeft()) {
      return left((resultFetchPokemonDetails as Left).value as Failure);
    }

    return right(
      (resultFetchPokemonDetails as Right).value as List<PokemonModel>,
    );
  }

  @override
  Future<Either<Failure, EvolutionChainModel>> getEvolutionChain(
    int pokemonId,
  ) async {
    // First, get the Pokemon species to get the evolution chain URL
    final speciesResult = await fetchPokemonSpecies(pokemonId);

    if (speciesResult.isLeft()) {
      return left((speciesResult as Left).value as Failure);
    }

    final speciesData = (speciesResult as Right).value as Map<String, dynamic>;
    final evolutionChainUrl = (speciesData['evolution_chain']
        as Map<String, dynamic>?)?['url'] as String?;

    if (evolutionChainUrl == null) {
      return left(
        const ServerFailure(
          message: 'Evolution chain URL not found for this Pokemon',
        ),
      );
    }

    // Extract evolution chain ID from URL
    final uri = Uri.parse(evolutionChainUrl);
    final pathSegments = uri.pathSegments;
    final evolutionChainId =
        int.tryParse(pathSegments[pathSegments.length - 2]);

    if (evolutionChainId == null) {
      return left(
        const ServerFailure(
          message: 'Invalid evolution chain URL',
        ),
      );
    }

    // Fetch the evolution chain
    return await fetchEvolutionChain(evolutionChainId);
  }
}

/// Fetches the list of Pokémon with pagination
Future<Either<Failure, List<dynamic>>> fetchPokemonList({
  int offset = 0,
  int limit = 20,
}) async {
  try {
    final response = await http.get(
      Uri.parse(
        ApiHelper.baseUrl +
            ApiHelper.getPokemonsUrl(
              offset: offset,
              limit: limit,
            ),
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return right(data['results'] as List<dynamic>);
    } else {
      return left(
        ServerFailure(
          message: 'Failed to load Pokémon list: ${response.statusCode}',
        ),
      );
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

/// Fetches Pokemon species data
Future<Either<Failure, Map<String, dynamic>>> fetchPokemonSpecies(
  int pokemonId,
) async {
  try {
    final response = await http.get(
      Uri.parse('${ApiHelper.baseUrl}pokemon-species/$pokemonId/'),
    );
    if (response.statusCode == 200) {
      return right(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      return left(
        ServerFailure(
          message: 'Failed to load Pokemon species: ${response.statusCode}',
        ),
      );
    }
  } catch (e) {
    return left(UnexpectedFailure(message: e.toString()));
  }
}

/// Fetches evolution chain data
Future<Either<Failure, EvolutionChainModel>> fetchEvolutionChain(
  int evolutionChainId,
) async {
  try {
    final response = await http.get(
      Uri.parse('${ApiHelper.baseUrl}evolution-chain/$evolutionChainId/'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return right(EvolutionChainModel.fromJson(data));
    } else {
      return left(
        ServerFailure(
          message: 'Failed to load evolution chain: ${response.statusCode}',
        ),
      );
    }
  } catch (e) {
    return left(UnexpectedFailure(message: e.toString()));
  }
}
