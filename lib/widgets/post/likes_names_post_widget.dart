import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/user.dart';
import 'package:social_network_application/view/tabs/profile.dart';

class LikesNamesPostWidget {
  static returnLikes(
      {required PostUpdateMini postUpdateMini, required BuildContext context}) {
    int value = postUpdateMini.likeQuantity - 1;

    ///
    if (postUpdateMini.liked && postUpdateMini.likeQuantity == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          children: [
            const SizedBox(
              width: 4.0,
            ),
            Icon(Icons.thumb_up_alt_outlined,
                size: ScopedModel.of<ThemeModel>(context).sizeTitle,
                color: ScopedModel.of<ThemeModel>(context).emphasis),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              "liked by ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ),
                );
              },
              child: Text(
                "You ",
                maxLines: 3,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                  letterSpacing:
                      ScopedModel.of<ThemeModel>(context).letterSpacingText,
                  color: ScopedModel.of<ThemeModel>(context).emphasis,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (postUpdateMini.liked && postUpdateMini.likeQuantity == 2) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          children: [
            const SizedBox(
              width: 4.0,
            ),
            Icon(Icons.thumb_up_alt_outlined,
                size: ScopedModel.of<ThemeModel>(context).sizeTitle,
                color: ScopedModel.of<ThemeModel>(context).emphasis),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              "liked by ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            postUpdateMini.like == null
                ? const Text("like null option 2")
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile(),
                        ),
                      );
                    },
                    child: Text(
                      "You ",
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                        letterSpacing: ScopedModel.of<ThemeModel>(context)
                            .letterSpacingText,
                        color: ScopedModel.of<ThemeModel>(context).emphasis,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
            Text(
              "and ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => User(userMini: postUpdateMini.like!),
                  ),
                );
              },
              child: Text(
                "${postUpdateMini.like!.name} ",
                maxLines: 3,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                  letterSpacing:
                      ScopedModel.of<ThemeModel>(context).letterSpacingText,
                  color: ScopedModel.of<ThemeModel>(context).emphasis,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (postUpdateMini.liked && postUpdateMini.likeQuantity > 2) {
      value = value - 1;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          children: [
            Icon(Icons.thumb_up_alt_outlined,
                size: ScopedModel.of<ThemeModel>(context).sizeTitle,
                color: ScopedModel.of<ThemeModel>(context).emphasis),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              "liked by ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            postUpdateMini.like == null
                ? const Text("like null option 3")
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile(),
                        ),
                      );
                    },
                    child: Text(
                      "You",
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                        letterSpacing: ScopedModel.of<ThemeModel>(context)
                            .letterSpacingText,
                        color: ScopedModel.of<ThemeModel>(context).emphasis,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
            Text(
              ", ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => User(userMini: postUpdateMini.like!),
                  ),
                );
              },
              child: Text(
                postUpdateMini.like!.name + " ",
                maxLines: 3,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                  letterSpacing:
                      ScopedModel.of<ThemeModel>(context).letterSpacingText,
                  color: ScopedModel.of<ThemeModel>(context).emphasis,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Text(
              "and ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              "$value ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              "others",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            // Text(
            //   "liked ",
            //   maxLines: 3,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
            //     letterSpacing:
            //         ScopedModel.of<ThemeModel>(context).letterSpacingText,
            //     color: ScopedModel.of<ThemeModel>(context).title,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            // Text(
            //   "this ",
            //   maxLines: 3,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
            //     letterSpacing:
            //         ScopedModel.of<ThemeModel>(context).letterSpacingText,
            //     color: ScopedModel.of<ThemeModel>(context).title,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            // Text(
            //   "post",
            //   maxLines: 3,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
            //     letterSpacing:
            //         ScopedModel.of<ThemeModel>(context).letterSpacingText,
            //     color: ScopedModel.of<ThemeModel>(context).title,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
          ],
        ),
      );
    } else if (!postUpdateMini.liked && postUpdateMini.likeQuantity > 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          children: [
            const SizedBox(
              width: 4.0,
            ),
            Icon(Icons.thumb_up_alt_outlined,
                size: ScopedModel.of<ThemeModel>(context).sizeTitle,
                color: ScopedModel.of<ThemeModel>(context).emphasis),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              "liked by ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            postUpdateMini.like == null
                ? const Text("like null option 4")
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              User(userMini: postUpdateMini.like!),
                        ),
                      );
                    },
                    child: Text(
                      "${postUpdateMini.like!.name} ",
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                        letterSpacing: ScopedModel.of<ThemeModel>(context)
                            .letterSpacingText,
                        color: ScopedModel.of<ThemeModel>(context).emphasis,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
            Text(
              "and ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              "$value ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              "others ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),

            // Text(
            //   "people ",
            //   maxLines: 3,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
            //     letterSpacing:
            //         ScopedModel.of<ThemeModel>(context).letterSpacingText,
            //     color: ScopedModel.of<ThemeModel>(context).title,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            // Text(
            //   "liked ",
            //   maxLines: 3,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
            //     letterSpacing:
            //         ScopedModel.of<ThemeModel>(context).letterSpacingText,
            //     color: ScopedModel.of<ThemeModel>(context).title,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            // Text(
            //   "this ",
            //   maxLines: 3,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
            //     letterSpacing:
            //         ScopedModel.of<ThemeModel>(context).letterSpacingText,
            //     color: ScopedModel.of<ThemeModel>(context).title,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            // Text(
            //   "post",
            //   maxLines: 3,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
            //     letterSpacing:
            //         ScopedModel.of<ThemeModel>(context).letterSpacingText,
            //     color: ScopedModel.of<ThemeModel>(context).title,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
          ],
        ),
      );
    } else if (!postUpdateMini.liked && postUpdateMini.likeQuantity == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          children: [
            const SizedBox(
              width: 4.0,
            ),
            Icon(Icons.thumb_up_alt_outlined,
                size: ScopedModel.of<ThemeModel>(context).sizeTitle,
                color: ScopedModel.of<ThemeModel>(context).emphasis),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              "liked by ",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                letterSpacing:
                    ScopedModel.of<ThemeModel>(context).letterSpacingText,
                color: ScopedModel.of<ThemeModel>(context).title,
                fontWeight: FontWeight.normal,
              ),
            ),
            postUpdateMini.like == null
                ? const Text("like null option 5")
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              User(userMini: postUpdateMini.like!),
                        ),
                      );
                    },
                    child: Text(
                      "${postUpdateMini.like!.name} ",
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                        letterSpacing: ScopedModel.of<ThemeModel>(context)
                            .letterSpacingText,
                        color: ScopedModel.of<ThemeModel>(context).emphasis,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
            // Text(
            //   "liked ",
            //   maxLines: 3,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
            //     letterSpacing:
            //         ScopedModel.of<ThemeModel>(context).letterSpacingText,
            //     color: ScopedModel.of<ThemeModel>(context).title,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            // Text(
            //   "this ",
            //   maxLines: 3,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
            //     letterSpacing:
            //         ScopedModel.of<ThemeModel>(context).letterSpacingText,
            //     color: ScopedModel.of<ThemeModel>(context).title,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            // Text(
            //   "post",
            //   maxLines: 3,
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
            //     letterSpacing:
            //         ScopedModel.of<ThemeModel>(context).letterSpacingText,
            //     color: ScopedModel.of<ThemeModel>(context).title,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
          ],
        ),
      );
    } else {
      return Container();
    }

    /*
    postUpdateMini.liked && postUpdateMini.likeQuantity == 1
        ? Text(
            " you",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
              letterSpacing:
                  ScopedModel.of<ThemeModel>(context).letterSpacingText,
              color: ScopedModel.of<ThemeModel>(context).emphasis,
              fontWeight: FontWeight.normal,
            ),
          )
        : postUpdateMini.liked && postUpdateMini.likeQuantity != 1
            ? Text(
                " you and others " + value.toString() + " people",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                  letterSpacing:
                      ScopedModel.of<ThemeModel>(context).letterSpacingText,
                  color: ScopedModel.of<ThemeModel>(context).emphasis,
                  fontWeight: FontWeight.normal,
                ),
              )
            : !postUpdateMini.liked &&
                    postUpdateMini.likeQuantity > 1
                ? Text(
                    " joão pedro and others " + value.toString() + " people",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: ScopedModel.of<ThemeModel>(context).sizeText,
                      letterSpacing:
                          ScopedModel.of<ThemeModel>(context).letterSpacingText,
                      color: ScopedModel.of<ThemeModel>(context).emphasis,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                : !postUpdateMini.liked &&
                        postUpdateMini.likeQuantity == 1
                    ? Text(
                        " joão pedro",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize:
                              ScopedModel.of<ThemeModel>(context).sizeText,
                          letterSpacing: ScopedModel.of<ThemeModel>(context)
                              .letterSpacingText,
                          color: ScopedModel.of<ThemeModel>(context).emphasis,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : Container();
                    */
  }
}
