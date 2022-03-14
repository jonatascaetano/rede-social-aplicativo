import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/worker_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/enuns/level.dart';
import 'package:social_network_application/scoped_model/new_worker_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class NewWorkerEntity extends StatefulWidget {
  EntityMini entityMini;
  BuildContext context;
  NewWorkerEntity({required this.entityMini, required this.context, Key? key}) : super(key: key);

  @override
  _NewWorkerEntityState createState() => _NewWorkerEntityState();
}

class _NewWorkerEntityState extends State<NewWorkerEntity> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<NewWorkerModel>(
          model: NewWorkerModel(),
          child: ScopedModelDescendant<NewWorkerModel>(builder: (context, child, worker) {
            return Form(
              key: _globalKey,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  title: Text(
                    "New Worker",
                    style: TextStyle(
                      color: theme.title,
                      fontSize: theme.sizeAppBar,
                      letterSpacing: theme.letterSpacingAppBar,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
                      child: ListView(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'inform your role';
                              }
                            },
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
                              if (_globalKey.currentState!.validate()) {
                                WorkerDTO workerDTO = WorkerDTO(idUser: worker.id, idEntity: widget.entityMini.id, role: controller.text, level: Level.ENTITY);
                                worker.createWorker(workerDTO: workerDTO, context: widget.context);
                              }
                            },
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                color: theme.buttonMainText,
                                fontSize: theme.sizeButton,
                                letterSpacing: theme.letterSpacingButton,
                                fontWeight: FontWeight.normal,
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
              ),
            );
          }));
    });
  }
}
