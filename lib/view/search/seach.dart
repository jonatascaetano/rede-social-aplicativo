import 'package:flutter/material.dart';
import 'package:social_network_application/view/search/results_search.dart';
import 'package:social_network_application/view/search/suggestions_search.dart';

class Search extends SearchDelegate {
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
