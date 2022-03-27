import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/report_dto.dart';
import 'package:social_network_application/entities/dto/user_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:social_network_application/enuns/level_report.dart';
import 'package:social_network_application/enuns/type_post.dart';
import 'package:social_network_application/enuns/type_report.dart';
import 'dart:io';

import 'package:social_network_application/view/authentication/login.dart';
import 'package:social_network_application/view/tabs/home/new_entity.dart';
import 'package:social_network_application/view/tabs/home/new_group.dart';
import 'package:social_network_application/view/tabs/home/new_post_quest.dart';
import 'package:social_network_application/view/tabs/home/new_post_talk.dart';
import 'package:social_network_application/widgets/post/update_post_widget_2.dart';

import 'support/language_model.dart';
import 'support/theme_model.dart';

class ProfileModel extends Model {
  static const String base = "https://jonatas-social-network-api.herokuapp.com/";

  late UserMini userMini;
  bool profileNull = true;
  bool load = false;
  bool imageIsNull = true;
  late File imageFile;
  List<PostUpdateMini> posts = [];
  List<dynamic> allPosts = [];
  List<dynamic> myPosts = [];
  bool postsAreNull = true;
  List<EntitySaveMini> goals = [];

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
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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
        await getAllPosts(context: context);
        await getMyPosts(context: context);
        await getGoals();
        break;
      default:
        load = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login()), (_) => false);
    }
  }

  getGoals() async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/$id/goals');
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("getGoals: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        goals = [];
        var itens = json.decode(response.body);
        for (var item in itens) {
          EntitySaveMini entitySaveMini = EntitySaveMini.fromMap(map: item as Map);
          goals.add(entitySaveMini);
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

  addImageProfile({required UserDTO userDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    try {
      //--save image firebase -/
      await FirebaseStorage.instance.ref().child('profile').child(userDTO.idUser! + ".jpg").putFile(imageFile).snapshot.ref.getDownloadURL().then((value) async {
        // ignore: avoid_print
        print('value: ' + value);
        userDTO.imageProfile = value;

        //--save image api -/
        var url = Uri.parse(base + 'users/put/add/image/profile');
        var response = await http.put(url, body: json.encode(userDTO.toMap()), headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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

  removeImageProfile({required UserDTO userDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    try {
      //--save image firebase -/

      await FirebaseStorage.instance
          .ref()
          .child('profile')
          .child(userDTO.imageProfile!)
          // ignore: avoid_print
          .delete()
          .onError((error, stackTrace) {
        // ignore: avoid_print
        print(error.toString() + ' : ' + stackTrace.toString());
      }).then((_) async {
        //--save image api -/
        var url = Uri.parse(base + 'users/put/remove/image/profile');
        var response = await http.put(url, body: json.encode(userDTO.toMap()), headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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
    var response = await http.put(url, body: json.encode(userDTO.toMap()), headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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
    var response = await http.put(url, body: json.encode(userDTO.toMap()), headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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

  updateDescription({required UserDTO userUpdateDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/description');
    var response = await http.put(url, body: json.encode(userUpdateDTO.toMap()), headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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
    var response = await http.put(url, body: json.encode(userDTO.toMap()), headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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

  updatePassword({required UserDTO userDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/password');
    var response = await http.put(url, body: json.encode(userDTO.toMap()), headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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
    var url = Uri.parse(base + 'users/get/user/$id/posts/my/$id');
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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

  updateLikePost({required BuildContext context, required String idPost}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'posts/put/like/post/$idPost/user/$id');
    var response = await http.put(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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

  removePost({required BuildContext context, required String idPost, required BuildContext contextScreenComment, required bool screenComment}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'posts/delete/post/$idPost/user/$id');
    var response = await http.delete(
      url,
      headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"},
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

  returnPostWidget({required Map post, required bool screenComment, required BuildContext contextPage}) {
    // ignore: avoid_print
    switch (post["typePost"]) {
      case TypePost.UPDATE:
        return UpdatePostWidget2(
          postUpdateMini: PostUpdateMini.fromMap(map: post),
          screenComment: screenComment,
          screenUser: false,
          contextPage: contextPage,
        );
      default:
    }
  }

  showDeletePostBottomSheet({required BuildContext context, required String idPost, required bool screenComment, required bool screenUser, required BuildContext contextPage}) {
    showModalBottomSheet<dynamic>(

        //isScrollControlled: true,
        context: context,
        builder: (context) {
          return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
            return BottomSheet(
                backgroundColor: theme.background,
                onClosing: () {},
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          if (!screenComment && !screenUser) {
                            removePost(
                              context: context,
                              idPost: idPost,
                              contextScreenComment: context,
                              screenComment: screenComment,
                            );
                          }
                          // else if (screenUser && !screenComment) {
                          //   ScopedModel.of<UserModel>(contextPage).removePost(
                          //     context: contextPage,
                          //     idPost: idPost,
                          //     contextScreenComment: context,
                          //     screenComment: screenComment,
                          //   );
                          // }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.delete),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.title,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      )
                    ],
                  );
                });
          });
        });
  }

  // showDeleteCommentBottomSheet(
  //     {required BuildContext context,
  //     required String idPost,
  //     required String idComment,
  //     required bool screenComment,
  //     required bool screenUser,
  //     required BuildContext contextPage}) {
  //   showModalBottomSheet<dynamic>(

  //       //isScrollControlled: true,
  //       context: context,
  //       builder: (context) {
  //         return ScopedModelDescendant<ThemeModel>(
  //             builder: (context, child, theme) {
  //           return BottomSheet(
  //               backgroundColor: theme.background,
  //               onClosing: () {},
  //               builder: (context) {
  //                 return Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     const SizedBox(
  //                       height: 16.0,
  //                     ),
  //                     GestureDetector(
  //                       onTap: () {
  //                         Navigator.pop(context);
  //                         ScopedModel.of<CommentModel>(contextPage)
  //                             .removeCommentPost(
  //                           context: contextPage,
  //                           idComment: idComment,
  //                           idPost: idPost,
  //                           screenUser: screenUser,
  //                         );
  //                       },
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Row(
  //                           children: [
  //                             const Icon(Icons.delete),
  //                             const SizedBox(
  //                               width: 8.0,
  //                             ),
  //                             Text(
  //                               'Delete',
  //                               style: TextStyle(
  //                                 fontSize: theme.sizeText,
  //                                 letterSpacing: theme.letterSpacingText,
  //                                 color: theme.title,
  //                                 fontWeight: FontWeight.normal,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 16.0,
  //                     )
  //                   ],
  //                 );
  //               });
  //         });
  //       });
  // }

  showOptionsPostBottomSheet({required BuildContext contextAncestor, required String idPost}) {
    showModalBottomSheet<dynamic>(

        //isScrollControlled: true,
        context: contextAncestor,
        builder: (context) {
          return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
            return BottomSheet(
                backgroundColor: theme.background,
                onClosing: () {},
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          ReportDTO reportDTO = ReportDTO(
                            id: null,
                            levelReport: LevelReport.POST,
                            idReported: idPost,
                            typeReport: null,
                            idAuthor: userMini.id,
                            release: DateTime.now().toString(),
                          );
                          showOptionsReport(contextAncestor: contextAncestor, reportDTO: reportDTO);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.outlined_flag),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'Report',
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.title,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      )
                    ],
                  );
                });
          });
        });
  }

  showOptionsCommentBottomSheet({required BuildContext contextAncestor, required String idComment}) {
    showModalBottomSheet<dynamic>(

        //isScrollControlled: true,
        context: contextAncestor,
        builder: (context) {
          return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
            return BottomSheet(
                backgroundColor: theme.background,
                onClosing: () {},
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          ReportDTO reportDTO = ReportDTO(
                            id: null,
                            levelReport: LevelReport.COMMENT,
                            idReported: idComment,
                            typeReport: null,
                            idAuthor: userMini.id,
                            release: DateTime.now().toString(),
                          );
                          showOptionsReport(contextAncestor: contextAncestor, reportDTO: reportDTO);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.outlined_flag),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'Report',
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.title,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  );
                });
          });
        });
  }

  showOptionsReport({required BuildContext contextAncestor, required ReportDTO reportDTO}) {
    notifyListeners();
    showDialog(
        context: contextAncestor,
        builder: (context) {
          return OptionReport(
            contextAncestor: contextAncestor,
            reportDTO: reportDTO,
          );
        });
  }

  report({required ReportDTO reportDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'reports/post');
    var response = await http.post(url, body: json.encode(reportDTO.toMap()), headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print('report: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reported')),
        );
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
    }
  }

  showOptionsAddPostBottomSheet({required BuildContext contextAncestor}) {
    showModalBottomSheet<dynamic>(
        //isScrollControlled: true,
        context: contextAncestor,
        builder: (context) {
          return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
            return BottomSheet(
                backgroundColor: theme.background,
                onClosing: () {},
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPostTalk()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.question_answer_outlined,
                                color: theme.emphasis,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'New Talk',
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.title,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPostQuest()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.quiz_outlined,
                                color: theme.emphasis,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'New Quest',
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.title,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewGroup()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.group_add,
                                color: theme.emphasis,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'New Group',
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.title,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          showListEntitiesBottomSheet(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: theme.emphasis,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'New Register',
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.title,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      )
                    ],
                  );
                });
          });
        });
  }

  showListEntitiesBottomSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
        //isScrollControlled: true,
        context: context,
        builder: (context) {
          return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
            return BottomSheet(
                backgroundColor: theme.background,
                onClosing: () {},
                builder: (context) {
                  return GridView.count(
                    childAspectRatio: 1.0 / 1.6,
                    crossAxisCount: 3,
                    children: LanguageModel().typeEntities.map((e) {
                      return GestureDetector(
                        child: Container(
                          color: Colors.transparent,
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child: Icon(
                                  LanguageModel().typeEntitiesIcon[LanguageModel().typeEntities.indexOf(e)],
                                  size: 30.0,
                                  color: theme.buttonText,
                                ),
                                backgroundColor: theme.button,
                                radius: 40.0,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                e,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: theme.buttonText,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewEntity(
                                        typeEntity: e,
                                      )));
                        },
                      );
                    }).toList(),
                  );
                });
          });
        });
  }
}

// ignore: must_be_immutable
class OptionReport extends StatefulWidget {
  BuildContext contextAncestor;
  ReportDTO reportDTO;
  OptionReport({
    required this.contextAncestor,
    required this.reportDTO,
    Key? key,
  }) : super(key: key);

  @override
  _OptionReportState createState() => _OptionReportState();
}

class _OptionReportState extends State<OptionReport> {
  String groupValue = '';

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: AlertDialog(
            backgroundColor: theme.background,
            title: const Text('Report Post'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<String>(
                      title: Text(
                        LanguageModel().typeReport[0],
                        style: TextStyle(
                          fontSize: theme.sizeText,
                          letterSpacing: theme.letterSpacingText,
                          color: theme.title,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      value: TypeReport.SEXUAL_CONTENT,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                        // ignore: avoid_print
                        print(groupValue);
                      }),
                  RadioListTile<String>(
                      title: Text(
                        LanguageModel().typeReport[1],
                        style: TextStyle(
                          fontSize: theme.sizeText,
                          letterSpacing: theme.letterSpacingText,
                          color: theme.title,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      value: TypeReport.VIOLENT_OR_REPULSIVE_CONTENT,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                        // ignore: avoid_print
                        print(groupValue);
                      }),
                  RadioListTile<String>(
                      title: Text(
                        LanguageModel().typeReport[2],
                        style: TextStyle(
                          fontSize: theme.sizeText,
                          letterSpacing: theme.letterSpacingText,
                          color: theme.title,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      value: TypeReport.HATEFUL_OR_ABUSIVE_CONTENT,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                        // ignore: avoid_print
                        print(groupValue);
                      }),
                  RadioListTile<String>(
                      title: Text(
                        LanguageModel().typeReport[3],
                        style: TextStyle(
                          fontSize: theme.sizeText,
                          letterSpacing: theme.letterSpacingText,
                          color: theme.title,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      value: TypeReport.HARMFUL_OR_DANGEROUS_ACTS,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                        // ignore: avoid_print
                        print(groupValue);
                      }),
                  RadioListTile<String>(
                      title: Text(
                        LanguageModel().typeReport[4],
                        style: TextStyle(
                          fontSize: theme.sizeText,
                          letterSpacing: theme.letterSpacingText,
                          color: theme.title,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      value: TypeReport.SPAM_OR_MISLEADING,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                        // ignore: avoid_print
                        print(groupValue);
                      }),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Divider(
                    height: 1.0,
                    thickness: 1.0,
                    color: theme.subtitle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            widget.reportDTO.typeReport = groupValue;
                            ScopedModel.of<ProfileModel>(widget.contextAncestor).report(
                              reportDTO: widget.reportDTO,
                              context: widget.contextAncestor,
                            );
                          },
                          child: const Text('Report')),
                    ],
                  )
                ],
              ),
            )),
      );
    });
  }
}
