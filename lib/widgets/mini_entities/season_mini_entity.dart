import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/scoped_model/season_mini_entity_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/season.dart';

// ignore: must_be_immutable
class SeasonMiniEntity extends StatefulWidget {
  SeasonMini seasonMini;
  SeasonMiniEntity({required this.seasonMini, Key? key}) : super(key: key);

  @override
  _SeasonMiniEntityState createState() => _SeasonMiniEntityState();
}

class _SeasonMiniEntityState extends State<SeasonMiniEntity> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<SeasonMiniEntityModel>(
          model: SeasonMiniEntityModel(seasonId: widget.seasonMini.id),
          child: ScopedModelDescendant<SeasonMiniEntityModel>(
              builder: (context, child, seasonMiniEntity) {
            return Container(
              width: 200.0,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(color: theme.shadow),
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
                      widget.seasonMini.image != null
                          ? Container(
                              height: 150,
                              width: 200,
                              decoration: BoxDecoration(
                                color: theme.shadow,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                                image: DecorationImage(
                                  image: NetworkImage(widget.seasonMini.image!),
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
                                  color: theme.buttonMainText,
                                  size: 150,
                                ),
                              ),
                            ),
                      // ? CircleAvatar(
                      //     backgroundImage: NetworkImage(
                      //         widget.seasonMini.images[0].toString()),
                      //     radius: 30.0,
                      //   )
                      // : CircleAvatar(
                      //     backgroundColor: theme.shadow,
                      //     child: Icon(
                      //       Icons.image,
                      //       size: 30.0,
                      //       color: theme.emphasis,
                      //     ),
                      //     radius: 30.0,
                      //   ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        widget.seasonMini.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          color: theme.title,
                          fontSize: theme.sizeTitle,
                          letterSpacing: theme.letterSpacingTitle,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'Episodes ' +
                            widget.seasonMini.episodeQuantity.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.subtitle,
                          fontSize: theme.sizeText,
                          letterSpacing: theme.letterSpacingText,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      // seasonMiniEntity.entitySaveMiniIsNull
                      //     ? Center(
                      //         child: Icon(
                      //           Icons.highlight_remove_sharp,
                      //           color: theme.detail,
                      //         ),
                      //       )
                      //     : Center(
                      //         child: Icon(
                      //           Icons.check_circle_outline,
                      //           color: theme.emphasis,
                      //         ),
                      //       )
                      // Text(
                      //     LanguageModel().entitiesCategories[
                      //         ConvertToEnum.convertTypeEntityToValue(
                      //             typeEntity: widget
                      //                 .seasonMini.entity.typeEntity)][1],
                      //     textAlign: TextAlign.center,
                      //   ),
                    ],
                  )),

                  /*
            widget.entitySaveMini == null
                ? Container()
                : Text(
                    LanguageModel().entitiesCategories[
                        ConvertToEnum.convertTypeEntityToValue(
                            typeEntity:
                                widget.seasonMini.entity.typeEntity)][1],
                  ),
                  */
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 1.0,
                      primary: theme.buttonMain,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Season(seasonMini: widget.seasonMini)));
                    },
                    child: Text(
                      "view",
                      style: TextStyle(
                        color: theme.buttonMainText,
                        fontSize: theme.sizeButton,
                        letterSpacing: theme.letterSpacingButton,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            );
          }));
    });
  }
}
