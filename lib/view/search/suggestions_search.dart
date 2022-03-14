import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/search_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/search/results_search.dart';

// ignore: must_be_immutable
class SuggestionsSearch extends StatefulWidget {
  String query;
  SuggestionsSearch({required this.query, Key? key}) : super(key: key);

  @override
  _SuggestionsSearchState createState() => _SuggestionsSearchState();
}

class _SuggestionsSearchState extends State<SuggestionsSearch> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<SearchModel>(
        model: SearchModel(),
        child: ScopedModelDescendant<SearchModel>(builder: (context, child, search) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<Set<String>>(
                future: search.getByNameSuggestions(
                  text: widget.query,
                ),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Container();
                    default:
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ResultSearch(
                                                  query: snapshot.data!.toList()[index],
                                                  result: false,
                                                )));
                                  },
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: theme.title,
                                        ),
                                        const SizedBox(
                                          width: 24.0,
                                        ),
                                        SizedBox(
                                          width: 200.0,
                                          child: Text(
                                            snapshot.data!.toList()[index],
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: theme.title,
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            });
                      }
                  }
                }),
          );
        }),
      );
    });
  }
}
