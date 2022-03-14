import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/search_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class ResultSearch extends StatefulWidget {
  String query;
  bool result;
  ResultSearch({required this.query, required this.result, Key? key}) : super(key: key);

  @override
  _ResultSearchState createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<SearchModel>(
        model: SearchModel(),
        child: ScopedModelDescendant<SearchModel>(builder: (context, child, search) {
          return ScopedModelDescendant<LanguageModel>(builder: (context, child, language) {
            return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
              return Scaffold(
                appBar: !widget.result
                    ? AppBar(
                        title: Text(
                        'Result to ' + widget.query,
                        style: TextStyle(color: theme.title),
                      ))
                    : null,
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Map>>(
                      future: search.getByNameResult(
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
                                    return search.goToViewMiniResult(map: snapshot.data![index]);
                                  });
                            }
                        }
                      }),
                ),
              );
            });
          });
        }),
      );
    });
  }
}
