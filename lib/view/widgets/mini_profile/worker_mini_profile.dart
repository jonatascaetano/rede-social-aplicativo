import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:social_network_application/scoped_model/database_model.dart';
import 'package:social_network_application/view/objects/entity.dart';

// ignore: must_be_immutable
class WorkerMiniProfile extends StatefulWidget {
  WorkerMini workerMini;
  bool isUser;
  WorkerMiniProfile({required this.workerMini, required this.isUser, Key? key})
      : super(key: key);

  @override
  _WorkerMiniProfileState createState() => _WorkerMiniProfileState();
}

class _WorkerMiniProfileState extends State<WorkerMiniProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DatabaseModel>(
        builder: (context, child, database) {
      return Stack(children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 150.0,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffce93d8)),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.workerMini.entity.image != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.workerMini.entity.image.toString()),
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
                    widget.workerMini.entity.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Entity(
                                  entityMini: widget.workerMini.entity)));
                    },
                    child: const Text("view"),
                  ),
                ],
              ),
            ),
          ),
        ),
        widget.isUser
            ? Positioned(
                top: 2.0,
                right: 2.0,
                child: IconButton(
                  onPressed: () async {
                    String? idWorker = await database.deleteWorker(
                        idWorker: widget.workerMini.id, idUser: database.id);
                    // ignore: avoid_print
                    print("ok worker deletedo: " + idWorker!);
                  },
                  icon: const Icon(Icons.clear_rounded),
                ),
              )
            : Container()
      ]);
    });
  }
}
