import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/worker_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/enuns/type_worker.dart';
import 'package:social_network_application/scoped_model/new_worker_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

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
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<NewWorkerModel>(
          model: NewWorkerModel(),
          child: ScopedModelDescendant<NewWorkerModel>(
              builder: (context, child, worker) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text(
                  "New Worker",
                  style: TextStyle(
                    color: theme.title,
                    fontSize: 24.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 30.0),
                    child: ListView(
                      children: [
                        TextField(
                          controller: controller,
                          minLines: 1,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            label: Text("role"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: theme.buttonMain,
                            elevation: 0.0,
                          ),
                          onPressed: () {
                            WorkerDTO workerDTO = WorkerDTO(
                                idUser: worker.id,
                                idEntity: widget.entityMini.id,
                                role: controller.text,
                                typeWorker: TypeWorker.ENTITY);
                            worker.createWorker(
                                workerDTO: workerDTO, context: widget.context);
                          },
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2.0,
                              color: theme.buttonMainText,
                            ),
                          ),
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
    });
  }
}
