import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/worker_dto.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/scoped_model/entity_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';

class NewWorkerModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;
  late String id;

  NewWorkerModel() {
    load = true;
    notifyListeners();
    getId();
    load = false;
    notifyListeners();
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id")!;
    return id;
  }

  createWorker(
      {required WorkerDTO workerDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'workers/post/worker');
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      },
      body: json.encode(workerDTO.toMap()),
    );
    // ignore: avoid_print
    print('createWorker: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        ScopedModel.of<ProfileModel>(context).getWorkers();
        ScopedModel.of<EntityModel>(context)
            .getWorkers(entityId: workerDTO.idEntity);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        load = false;
        notifyListeners();
    }
  }
}
