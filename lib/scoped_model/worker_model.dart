import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/scoped_model/profile_model.dart';

class WorkerModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  deleteWorker(
      {required WorkerMini workerMini, required BuildContext context}) async {
    String id = await getId();
    var url =
        Uri.parse(base + 'workers/delete/worker/${workerMini.id}/user/$id');
    var response = await http.delete(url);
    // ignore: avoid_print
    print("deleteWorker: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        ScopedModel.of<ProfileModel>(context).getWorkers();
        break;
    }
  }
}
