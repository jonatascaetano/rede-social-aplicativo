import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/worker_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/enuns/type_worker.dart';
import 'package:social_network_application/scoped_model/new_worker_model.dart';

// ignore: must_be_immutable
class NewWorkerEntity extends StatefulWidget {
  EntityMini entityMini;
  BuildContext context;
  NewWorkerEntity({required this.entityMini, required this.context, Key? key})
      : super(key: key);

  @override
  _NewWorkerEntityState createState() => _NewWorkerEntityState();
}

class _NewWorkerEntityState extends State<NewWorkerEntity> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<NewWorkerModel>(
        model: NewWorkerModel(),
        child: ScopedModelDescendant<NewWorkerModel>(
            builder: (context, child, worker) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: const Text(
                "New Worker",
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: controller,
                        minLines: 1,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          label: Text("role"),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          WorkerDTO workerDTO = WorkerDTO(
                              idUser: worker.id,
                              idEntity: widget.entityMini.id,
                              role: controller.text,
                              typeWorker: TypeWorker.ENTITY);
                          worker.createWorker(
                              workerDTO: workerDTO, context: widget.context);
                        },
                        child: const Text("Confirm"),
                      ),
                    ],
                  ),
                ),
                worker.load
                    ? Positioned(
                        bottom: 0.1,
                        child: SizedBox(
                          height: 5.0,
                          width: MediaQuery.of(context).size.width,
                          child: const LinearProgressIndicator(),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        }));
  }
}
