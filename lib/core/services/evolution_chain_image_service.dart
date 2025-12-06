import 'dart:convert';

import 'package:flutter_pokedex/core/constants/api_helper.dart';
import 'package:flutter_pokedex/data/models/remote_models/remote_models_exports.dart';
import 'package:http/http.dart' as http;

/// Service to load Pokemon images for evolution chain
class EvolutionChainImageService {
  /// Loads images for all Pokemon in the evolution chain
  static Future<Map<String, String>> loadPokemonImages(
    ChainLink? chain,
  ) async {
    final Map<String, String> pokemonImages = {};

    if (chain == null) return pokemonImages;

    await _loadPokemonImageForChain(chain, pokemonImages);

    return pokemonImages;
  }

  static Future<void> _loadPokemonImageForChain(
    ChainLink chain,
    Map<String, String> images,
  ) async {
    // Extract Pokemon ID from species URL
    final speciesUrl = chain.speciesUrl;
    if (speciesUrl != null && chain.speciesName != null) {
      final uri = Uri.parse(speciesUrl);
      final pathSegments = uri.pathSegments;
      final speciesId = pathSegments[pathSegments.length - 2];

      // Fetch Pokemon data to get image
      try {
        final pokemonResponse = await http.get(
          Uri.parse('${ApiHelper.baseUrl}pokemon/$speciesId/'),
        );

        if (pokemonResponse.statusCode == 200) {
          final pokemonData =
              jsonDecode(pokemonResponse.body) as Map<String, dynamic>;
          final sprites = pokemonData['sprites'] as Map<String, dynamic>?;
          final other = sprites?['other'] as Map<String, dynamic>?;
          final officialArtwork =
              other?['official-artwork'] as Map<String, dynamic>?;
          final imageUrl = officialArtwork?['front_default'] as String?;

          if (imageUrl != null) {
            images[chain.speciesName!] = imageUrl;
          }
        }
      } catch (e) {
        // Silently fail for individual Pokemon images
      }
    }

    // Recursively load images for evolved forms
    if (chain.evolvesTo != null) {
      for (final evolvedForm in chain.evolvesTo!) {
        await _loadPokemonImageForChain(evolvedForm, images);
      }
    }
  }
}

