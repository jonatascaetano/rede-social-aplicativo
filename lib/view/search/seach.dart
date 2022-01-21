import 'package:flutter/material.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/search/results_search.dart';
import 'package:social_network_application/view/search/suggestions_search.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    //assert(context != null);
    final ThemeData theme = Theme.of(context);
    //assert(theme != null);
    return ThemeModel().dark
        ? theme.copyWith(
            primaryColor: const Color(0xff1f1f1f),
            inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1f1f1f))),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1f1f1f))),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1f1f1f))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1f1f1f))),
            ),
          )
        : theme.copyWith(
            primaryColor: Colors.white,
            inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
          );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ResultSearch(
      query: query,
      result: true,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SuggestionsSearch(
      query: query,
    );
  }
}
