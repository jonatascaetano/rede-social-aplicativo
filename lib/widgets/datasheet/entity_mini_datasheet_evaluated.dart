import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/entity.dart';

// ignore: must_be_immutable
class EntityMiniDatasheetEvaluated extends StatefulWidget {
  EntitySaveMini entitySaveMini;
  EntityMiniDatasheetEvaluated({required this.entitySaveMini, Key? key})
      : super(key: key);

  @override
  _EntityMiniDatasheetEvaluatedState createState() =>
      _EntityMiniDatasheetEvaluatedState();
}

class _EntityMiniDatasheetEvaluatedState
    extends State<EntityMiniDatasheetEvaluated> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Stack(children: [
        Container(
          margin: const EdgeInsets.all(4.0),
          width: 200.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.shadow,
            ), //  const Color(0xffce93d8)),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Column(
                children: [
                  widget.entitySaveMini.entity!.image != null
                      ? Container(
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            color: theme.shadow,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  widget.entitySaveMini.entity!.image!),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            color: theme.shadow,
                          ),
                          height: 150,
                          width: 200,
                          child: Center(
                            child: Icon(
                              Icons.image,
                              color: theme.emphasis,
                              size: 100,
                            ),
                          )),
                  // ? CircleAvatar(
                  //     backgroundImage: NetworkImage(widget
                  //         .workerMini.entity.images[0]
                  //         .toString()),
                  //     radius: 30.0,
                  //   )
                  // : CircleAvatar(
                  //     backgroundColor: Colors.grey[300],
                  //     child: const Icon(
                  //       Icons.image,
                  //       size: 30.0,
                  //     ),
                  //     radius: 30.0,
                  //   ),
                  const SizedBox(
                    height: 8.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 0.0),
                    child: Text(
                      widget.entitySaveMini.entity!.name,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                        color: theme.title,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 2.0,
              ),
              Container(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.star,
                      //size: 50,
                      color: widget.entitySaveMini.evaluation! >= 1
                          ? Colors.yellow[700]
                          : theme.icon,
                    ),
                    Icon(
                      Icons.star,
                      //size: 50,
                      color: widget.entitySaveMini.evaluation! >= 2
                          ? Colors.yellow[700]
                          : theme.icon,
                    ),
                    Icon(
                      Icons.star,
                      //size: 50,
                      color: widget.entitySaveMini.evaluation! >= 3
                          ? Colors.yellow[700]
                          : theme.icon,
                    ),
                    Icon(
                      Icons.star,
                      //size: 50,
                      color: widget.entitySaveMini.evaluation! >= 4
                          ? Colors.yellow[700]
                          : theme.icon,
                    ),
                    Icon(
                      Icons.star,
                      //size: 50,
                      color: widget.entitySaveMini.evaluation! >= 5
                          ? Colors.yellow[700]
                          : theme.icon,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Entity(
                                  entityMini: widget.entitySaveMini.entity!,
                                  datasheetIsOpen: true,
                                )));
                  },
                  child: Text(
                    "view",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.0,
                      color: theme.buttonMainText,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: theme.buttonMain,
                    elevation: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]);
    });
  }
}
