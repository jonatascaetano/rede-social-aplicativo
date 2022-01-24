import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/search/results_search.dart';
import 'package:social_network_application/view/search/suggestions_search.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    //assert(context != null);
    final ThemeData theme = Theme.of(context);
    //assert(theme != null);
    return ScopedModel.of<ThemeModel>(context).dark
        ? theme.copyWith(
            primaryColor: const Color(0xff1d1f27),
            inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1d1f27))),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1d1f27))),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1d1f27))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1d1f27))),
            ),
            textTheme: const TextTheme(
              headline6: TextStyle(
                fontSize: 21,
                //decoration:TextDecoration.none,
                decorationThickness: 0.0000001,
                //decorationColor: Colors.transparent, // color of text underline
              ),
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
            textTheme: const TextTheme(
              headline6: TextStyle(
                fontSize: 21,
                //decoration:TextDecoration.none,
                decorationThickness: 0.0000001,
                //decorationColor: Colors.transparent, // color of text underline
              ),
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
