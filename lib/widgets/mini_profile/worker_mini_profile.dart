import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/scoped_model/worker_model.dart';
import 'package:social_network_application/view/objects/entity.dart';

// ignore: must_be_immutable
class WorkerMiniProfile extends StatefulWidget {
  WorkerMini workerMini;
  bool isUser;
  WorkerMiniProfile({required this.workerMini, required this.isUser, Key? key}) : super(key: key);

  @override
  _WorkerMiniProfileState createState() => _WorkerMiniProfileState();
}

class _WorkerMiniProfileState extends State<WorkerMiniProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<WorkerModel>(
          model: WorkerModel(),
          child: ScopedModelDescendant<WorkerModel>(builder: (context, child, worker) {
            return Stack(children: [
              Container(
                margin: const EdgeInsets.all(4.0),
                width: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.shadow,
                  ), //  const Color(0xffce93d8)),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        widget.workerMini.entity.image != null
                            ? Container(
                                height: 150,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: theme.shadow,
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                  image: DecorationImage(
                                    image: NetworkImage(widget.workerMini.entity.image!),
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
                          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                          child: Text(
                            widget.workerMini.entity.name,
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

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                          child: Text(
                            widget.workerMini.role.toLowerCase(),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 1.0,
                              color: theme.subtitle,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Entity(
                                        entityMini: widget.workerMini.entity,
                                        datasheetIsOpen: false,
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
              widget.isUser
                  ? Positioned(
                      top: 2.0,
                      right: 2.0,
                      child: IconButton(
                        onPressed: () {
                          worker.deleteWorker(workerMini: widget.workerMini, context: context);
                        },
                        icon: Icon(
                          Icons.clear_rounded,
                          color: theme.subtitle,
                        ),
                      ),
                    )
                  : Container()
            ]);
          }));
    });
  }
}
