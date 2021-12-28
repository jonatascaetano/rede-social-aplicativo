import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/auxiliar/language_model.dart';
import 'package:social_network_application/scoped_model/auxiliar/theme_model.dart';
import 'package:social_network_application/scoped_model/search_model.dart';

// ignore: must_be_immutable
class ResultSearch extends StatefulWidget {
  String query;
  bool result;
  ResultSearch({required this.query, required this.result, Key? key})
      : super(key: key);

  @override
  _ResultSearchState createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<SearchModel>(
      model: SearchModel(),
      child:
          ScopedModelDescendant<SearchModel>(builder: (context, child, search) {
        return ScopedModelDescendant<LanguageModel>(
            builder: (context, child, language) {
          return ScopedModelDescendant<ThemeModel>(
              builder: (context, child, theme) {
            return Scaffold(
              body: Padding(
                padding: widget.result
                    ? const EdgeInsets.all(8.0)
                    : const EdgeInsets.fromLTRB(8, 40, 8, 8),
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
                                  return search.goToViewMiniResult(
                                      map: snapshot.data![index]);
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
  }
}
