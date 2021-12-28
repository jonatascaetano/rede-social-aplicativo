import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'dart:convert';

import 'package:social_network_application/entities/mini_dto/worker_mini.dart';

class ProfileModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  List<WorkerMini> workers = [];
  late UserMini userMini;
  bool profileNull = true;
  bool load = false;

  ProfileModel() {
    getProfile();
    getWorkers();
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getProfile() async {
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/get/user/$id');
    var response = await http.get(url);
    // ignore: avoid_print
    print('getProfile: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item);
        userMini = UserMini.fromMap(map: item as Map);
        profileNull = false;
        load = false;
        notifyListeners();
    }
  }

  getWorkers() async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/get/user/$id/workers');
    var response = await http.get(url);
    // ignore: avoid_print
    print("getWorkersUser: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        workers = [];
        var itens = json.decode(response.body);
        for (var item in itens) {
          WorkerMini workerMini = WorkerMini.fromMap(map: item as Map);
          workers.add(workerMini);
          notifyListeners();
        }
        load = false;
        notifyListeners();
        break;
    }
  }

  getPost() {}

  updateImage() {}
  updateName() {}
  updateCity() {}
  updateDescription() {}
}
