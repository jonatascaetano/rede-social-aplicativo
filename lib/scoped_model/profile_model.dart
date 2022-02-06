import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/user_dto.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'dart:convert';

import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network_application/enuns/type_post.dart';
import 'dart:io';

import 'package:social_network_application/view/authentication/login.dart';
import 'package:social_network_application/widgets/post/update_post_widget.dart';

class ProfileModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  List<WorkerMini> workers = [];
  late UserMini userMini;
  bool profileNull = true;
  bool load = false;
  bool imageIsNull = true;
  late File imageFile;
  List<PostUpdateMini> posts = [];
  List<dynamic> allPosts = [];
  List<dynamic> myPosts = [];
  bool postsAreNull = true;

  //ProfileModel({required BuildContext context}) {
  //   getProfile(context: context);
  //   getWorkers();
  //   getPosts();
  // }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getProfile({required BuildContext context}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/get/user/$id');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print('getProfile: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item);
        userMini = UserMini.fromMap(map: item as Map);
        profileNull = false;
        notifyListeners();
        load = false;
        notifyListeners();
        getWorkers();
        getAllPosts(context: context);
        getMyPosts(context: context);
        break;
      default:
        load = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (_) => false);
    }
  }

  getWorkers() async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/get/user/$id/workers');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
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

  loadImage() async {
    load = true;
    notifyListeners();
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(xFile!.path);
    load = false;
    imageIsNull = false;
    notifyListeners();
  }

  removeImage() async {
    load = true;
    notifyListeners();
    load = false;
    imageIsNull = true;
    notifyListeners();
  }

  addImageProfile(
      {required UserDTO userDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    try {
      //--save image firebase -/
      await FirebaseStorage.instance
          .ref()
          .child('profile')
          .child(userDTO.idUser! + ".jpg")
          .putFile(imageFile)
          .snapshot
          .ref
          .getDownloadURL()
          .then((value) async {
        // ignore: avoid_print
        print('value: ' + value);
        userDTO.image = value;

        //--save image api -/
        var url = Uri.parse(base + 'users/put/add/image');
        var response =
            await http.put(url, body: json.encode(userDTO.toMap()), headers: {
          "Accept": "application/json; charset=utf-8",
          "content-type": "application/json; charset=utf-8"
        });
        // ignore: avoid_print
        print("updateImage: " + response.statusCode.toString());
        switch (response.statusCode) {
          case 202:
            getProfile(context: context);
            load = false;
            imageIsNull = true;
            notifyListeners();
            Navigator.pop(context);
            break;
          default:
            load = false;
            imageIsNull = true;
            notifyListeners();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Try again later')),
            );
            break;
        }
        //**save image api */
      });

      //**save image firebase */

    } catch (e) {
      load = false;
      imageIsNull = true;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again later')),
      );
    }
  }

  removeImageProfile(
      {required UserDTO userDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    try {
      //--save image firebase -/

      await FirebaseStorage.instance
          .ref()
          .child('profile')
          .child(userDTO.image!)
          // ignore: avoid_print
          .delete()
          .onError((error, stackTrace) {
        // ignore: avoid_print
        print(error.toString() + ' : ' + stackTrace.toString());
      }).then((_) async {
        //--save image api -/
        var url = Uri.parse(base + 'users/put/remove/image');
        var response =
            await http.put(url, body: json.encode(userDTO.toMap()), headers: {
          "Accept": "application/json; charset=utf-8",
          "content-type": "application/json; charset=utf-8"
        });
        // ignore: avoid_print
        print("deleteImage: " + response.statusCode.toString());
        switch (response.statusCode) {
          case 202:
            getProfile(context: context);
            load = false;
            imageIsNull = true;
            notifyListeners();
            Navigator.pop(context);
            break;
          default:
            load = false;
            imageIsNull = true;
            notifyListeners();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Try again later')),
            );
            break;
        }
        //**save image api */
      });
      // ignore: avoid_print

      //**save image firebase */

    } catch (e) {
      load = false;
      imageIsNull = true;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again later')),
      );
    }
  }

  updateName({required UserDTO userDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/name');
    var response =
        await http.put(url, body: json.encode(userDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateName: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getProfile(context: context);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      case 406:
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('invalid name')),
        );
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updatePlace({required UserDTO userDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/place');
    var response =
        await http.put(url, body: json.encode(userDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateCity: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getProfile(context: context);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updateDescription(
      {required UserDTO userUpdateDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/description');
    var response =
        await http.put(url, body: json.encode(userUpdateDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateDescription: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getProfile(context: context);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updateEmail({required UserDTO userDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/email');
    var response =
        await http.put(url, body: json.encode(userDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateEmail: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getProfile(context: context);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      case 400:
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('invalid email')),
        );
        break;
      case 406:
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('invalid email')),
        );
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updatePassword(
      {required UserDTO userDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/password');
    var response =
        await http.put(url, body: json.encode(userDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updatePassword: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getProfile(context: context);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  getAllPosts({required BuildContext context}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'posts/get/user/$id/all');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("getAllPosts: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        //posts = [];
        allPosts = [];
        var itens = json.decode(response.body);
        allPosts = itens;
        getMyPosts(context: context);
        // for (var item in itens) {
        //   if (item['typePost'] == "UPDATE") {
        //     PostUpdateMini postUpdateMini = PostUpdateMini.fromMap(map: item);
        //     posts.add(postUpdateMini);
        //   }
        // }
        notifyListeners();
        postsAreNull = false;
        notifyListeners();
        load = false;
        notifyListeners();
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  getMyPosts({required BuildContext context}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/get/user/$id/posts/my');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("getMyPosts: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        //posts = [];
        myPosts = [];
        var itens = json.decode(response.body);
        myPosts = itens;
        // for (var item in itens) {
        //   if (item['typePost'] == "UPDATE") {
        //     PostUpdateMini postUpdateMini = PostUpdateMini.fromMap(map: item);
        //     posts.add(postUpdateMini);
        //   }
        // }
        notifyListeners();
        load = false;
        notifyListeners();
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updateLikePost(
      {required BuildContext context, required String idPost}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'posts/put/like/post/$idPost/user/$id');
    var response = await http.put(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateLikePost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getAllPosts(context: context);
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  removePost({required BuildContext context, required String idPost}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'posts/delete/post/$idPost/user/$id');
    var response = await http.delete(
      url,
      headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      },
    );
    // ignore: avoid_print
    print("removePost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        getAllPosts(context: context);
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  returnPostWidget(
      {required Map post,
      required bool screenComment,
      required BuildContext contextPage}) {
    // ignore: avoid_print
    switch (post["typePost"]) {
      case TypePost.UPDATE:
        return UpdatePostWidget(
          postUpdateMini: PostUpdateMini.fromMap(map: post),
          screenComment: screenComment,
          screenUser: false,
          contextPage: contextPage,
        );
      default:
    }
  }
}
