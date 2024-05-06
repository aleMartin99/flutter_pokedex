// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/search_bloc/search_bloc.dart';

///SearchBar class
class SearchField extends StatefulWidget {
  ///
  const SearchField({
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final searchBlocContextToDispose;

  @override
  void initState() {
    // Storing a reference to the context of the SearchBloc
    searchBlocContextToDispose = context.read<SearchBloc>();
    super.initState();
  }

  @override
  void dispose() {
    searchBlocContextToDispose.add(SearchDeactivatedEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(186, 226, 227, 230),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        // ignore: avoid_print
        onChanged: (value) {
          if (value.isNotEmpty) {
            context
                .read<SearchBloc>()
                .add(SearchActivatedEvent(searchWord: value));
          } else {
            context.read<SearchBloc>().add(SearchDeactivatedEvent());
          }
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13.5),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: 'Search a pokemon',
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
