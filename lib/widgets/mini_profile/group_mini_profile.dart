import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/group_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/group.dart';

// ignore: must_be_immutable
class GroupMiniProfile extends StatefulWidget {
  GroupMini group;
  GroupMiniProfile({required this.group, Key? key}) : super(key: key);

  @override
  State<GroupMiniProfile> createState() => _GroupMiniProfileState();
}

class _GroupMiniProfileState extends State<GroupMiniProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Stack(children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Group(
                  idGroup: widget.group.id,
                ),
              ),
            );
          },
          child: SizedBox(
            width: 120.0,
            child: Column(
              children: [
                widget.group.image != null
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: theme.shadow,
                          //borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                          image: DecorationImage(
                            image: NetworkImage(widget.group.image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
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
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  widget.group.name,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: theme.sizeText,
                    letterSpacing: theme.letterSpacingTitle,
                    color: theme.emphasis,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  widget.group.quantityMembers.toString() + " members",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: theme.sizeTextMini,
                    letterSpacing: theme.letterSpacingText,
                    color: theme.subtitle,
                    fontWeight: FontWeight.normal,
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
