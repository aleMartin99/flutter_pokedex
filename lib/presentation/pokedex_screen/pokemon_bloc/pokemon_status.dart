// ignore_for_file: public_member_api_docs

part of 'pokemon_bloc.dart';

enum PokemonStatus {
  initial,
  loading,
  loadingMore,
  loadingToggleCaptured,
  successLoadCaptured,
  success,
  isCaptured,
  isNotCaptured,
  failure,
}
