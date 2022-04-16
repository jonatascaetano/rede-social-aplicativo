import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/entity2.dart';

// ignore: must_be_immutable
class EntityMiniProfileEvaluated extends StatefulWidget {
  EntitySaveMini entitySaveMini;
  EntityMiniProfileEvaluated({required this.entitySaveMini, Key? key}) : super(key: key);

  @override
  _EntityMiniProfileEvaluatedState createState() => _EntityMiniProfileEvaluatedState();
}

class _EntityMiniProfileEvaluatedState extends State<EntityMiniProfileEvaluated> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Stack(children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Entity2(
                          idEntity: widget.entitySaveMini.entity.id,
                          datasheetIsOpen: true,
                        )));
          },
          child: SizedBox(
            width: 120.0,
            child: Column(
              children: [
                widget.entitySaveMini.entity.image != null
                    ? Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: theme.shadow,
                              // borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                              image: DecorationImage(
                                image: NetworkImage(widget.entitySaveMini.entity.image!),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0.0,
                            right: 20.0,
                            child: Icon(
                              Icons.bookmark_sharp,
                              color: widget.entitySaveMini.category == 1
                                  ? Colors.blue.shade800
                                  : widget.entitySaveMini.category == 2
                                      ? Colors.yellow
                                      : widget.entitySaveMini.category == 3
                                          ? Colors.red.shade800
                                          : widget.entitySaveMini.category == 4
                                              ? Colors.black
                                              : Colors.transparent,
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                //borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                                color: theme.shadow,
                              ),
                              height: 100,
                              width: 100,
                              child: Center(
                                child: Icon(
                                  Icons.image,
                                  color: theme.emphasis,
                                  size: 40,
                                ),
                              )),
                          Positioned(
                            top: 0.0,
                            right: 20.0,
                            child: Icon(
                              Icons.bookmark_sharp,
                              color: widget.entitySaveMini.category == 1
                                  ? Colors.blue.shade800
                                  : widget.entitySaveMini.category == 2
                                      ? Colors.yellow
                                      : widget.entitySaveMini.category == 3
                                          ? Colors.red.shade800
                                          : widget.entitySaveMini.category == 4
                                              ? Colors.black
                                              : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  widget.entitySaveMini.entity.name,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: theme.sizeText,
                    letterSpacing: theme.letterSpacingText,
                    color: theme.emphasis,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  width: 90.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: widget.entitySaveMini.evaluation! >= 1 ? Colors.yellow[700] : theme.icon,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: widget.entitySaveMini.evaluation! >= 2 ? Colors.yellow[700] : theme.icon,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: widget.entitySaveMini.evaluation! >= 3 ? Colors.yellow[700] : theme.icon,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: widget.entitySaveMini.evaluation! >= 4 ? Colors.yellow[700] : theme.icon,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: widget.entitySaveMini.evaluation! >= 5 ? Colors.yellow[700] : theme.icon,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]);
    });
  }
}
