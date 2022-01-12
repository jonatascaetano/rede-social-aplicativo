import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:social_network_application/scoped_model/worker_model.dart';
import 'package:social_network_application/view/objects/user.dart';

// ignore: must_be_immutable
class WorkerMiniEntity extends StatefulWidget {
  WorkerMini workerMini;
  String idUser;
  WorkerMiniEntity({required this.workerMini, required this.idUser, Key? key})
      : super(key: key);

  @override
  _WorkerMiniEntityState createState() => _WorkerMiniEntityState();
}

class _WorkerMiniEntityState extends State<WorkerMiniEntity> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<WorkerModel>(
        model: WorkerModel(),
        child: ScopedModelDescendant<WorkerModel>(
            builder: (context, child, worker) {
          return GestureDetector(
            onTap: () {
              if (widget.idUser != widget.workerMini.user.id) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            User(userMini: widget.workerMini.user)));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: 150.0,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffce93d8)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      widget.workerMini.user.image != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                  widget.workerMini.user.image.toString()),
                              radius: 30.0,
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: const Icon(
                                Icons.person,
                                size: 30.0,
                              ),
                              radius: 30.0,
                            ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        widget.workerMini.role,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        widget.workerMini.user.name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
