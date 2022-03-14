import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/scoped_model/worker_model.dart';
import 'package:social_network_application/view/objects/user.dart';

// ignore: must_be_immutable
class WorkerMiniEntity extends StatefulWidget {
  WorkerMini workerMini;
  String idUser;
  WorkerMiniEntity({required this.workerMini, required this.idUser, Key? key}) : super(key: key);

  @override
  _WorkerMiniEntityState createState() => _WorkerMiniEntityState();
}

class _WorkerMiniEntityState extends State<WorkerMiniEntity> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<WorkerModel>(
          model: WorkerModel(),
          child: ScopedModelDescendant<WorkerModel>(builder: (context, child, worker) {
            return GestureDetector(
              onTap: () {
                if (widget.idUser != widget.workerMini.user.id) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => User(userMini: widget.workerMini.user)));
                }
              },
              child: Container(
                margin: const EdgeInsets.all(4.0),
                width: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.shadow),
                  //borderRadius: BorderRadius.circular(8.0),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    widget.workerMini.user.imageProfile != null
                        ? Container(
                            height: 150,
                            width: 200,
                            decoration: BoxDecoration(
                              color: theme.shadow,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                              image: DecorationImage(
                                image: NetworkImage(widget.workerMini.user.imageProfile!),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                              color: theme.shadow,
                            ),
                            height: 150,
                            width: 200,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                color: theme.emphasis,
                                size: 150,
                              ),
                            ),
                          ),
                    // ? CircleAvatar(
                    //     backgroundImage: NetworkImage(widget
                    //         .workerMini.user.images[0]
                    //         .toString()),
                    //     radius: 30.0,
                    //   )
                    // : CircleAvatar(
                    //     backgroundColor: Colors.grey[300],
                    //     child: const Icon(
                    //       Icons.person,
                    //       size: 30.0,
                    //     ),
                    //     radius: 30.0,
                    //   ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      widget.workerMini.user.name,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                        color: theme.title,
                      ),
                    ),

                    const SizedBox(
                      height: 4.0,
                    ),

                    Text(
                      widget.workerMini.role.toLowerCase(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.0,
                        color: theme.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }));
    });
  }
}
