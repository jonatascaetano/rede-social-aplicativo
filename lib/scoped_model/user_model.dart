import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/report_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:social_network_application/enuns/level_report.dart';
import 'package:social_network_application/enuns/type_post.dart';
import 'package:social_network_application/enuns/type_report.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/widgets/post/update_post_widget_2.dart';

import 'support/language_model.dart';
import 'support/theme_model.dart';

class UserModel extends Model {
  static const String base = "https://jonatas-social-network-api.herokuapp.com/";

  late bool showFollowButton = false;
  late bool isFollowing;
  List<WorkerMini> workers = [];
  bool profileNull = true;
  late UserMini userMini;
  bool load = false;
  List<dynamic> myPosts = [];
  late String idUSer;
  bool blocked = false;
  List<EntitySaveMini> goals = [];

  UserModel({required String idUser, required BuildContext context}) {
    getWorkersUser(idUser: idUser);
    getProfile(idUser: idUser, context: context);
    checkFollowing(idUser: idUser);
    isBlocked(idUser: idUser);
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getProfile({required String idUser, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/get/user/$idUser');
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
        getGoalsUser(id: userMini.id);
        load = false;
        notifyListeners();
        getMyPosts(context: context);
    }
  }

  getWorkersUser({required String idUser}) async {
    var url = Uri.parse(base + 'users/get/user/$idUser/workers');
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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
        notifyListeners();
        break;
    }
  }

  getGoalsUser({required String id}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/$id/goals');
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("getGoalsUser: " + response.statusCode.toString());
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

  checkFollowing({required String idUser}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'followers/get/check/following/user/$id/following/$idUser');
    // ignore: avoid_print
    print("follower id: $idUser, following id: $id");
    var response = await http.get(url);
    // ignore: avoid_print
    print("checkFollowing: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        isFollowing = true;
        showFollowButton = true;
        load = false;
        notifyListeners();
        break;
      case 404:
        isFollowing = false;
        showFollowButton = true;
        load = false;
        notifyListeners();
        break;
      default:
        showFollowButton = false;
        load = false;
        notifyListeners();
    }
  }

  removeFollowing({required String idFollowing, required BuildContext context}) async {
    load = true;
    notifyListeners();
    String idFollower = await getId();
    // ignore: avoid_print
    print(idFollower);
    var url = Uri.parse(base + 'followers/delete/follower/$idFollower/following/$idFollowing');
    var response = await http.delete(url);
    // ignore: avoid_print
    print('removeFollowing: ' + response.statusCode.toString());
    ScopedModel.of<ProfileModel>(context).getProfile(context: context);
    getProfile(idUser: idFollowing, context: context);
    checkFollowing(idUser: idFollowing);
    notifyListeners();
  }

  addFollowing({required String idFollowing, required BuildContext context}) async {
    load = true;
    notifyListeners();
    String idFollower = await getId();
    // ignore: avoid_print
    print(idFollower);
    var url = Uri.parse(base + 'followers/post/follower/$idFollower/following/$idFollowing');
    var response = await http.post(url);
    // ignore: avoid_print
    print('addFollowing: ' + response.statusCode.toString());
    ScopedModel.of<ProfileModel>(context).getProfile(context: context);
    getProfile(idUser: idFollowing, context: context);
    checkFollowing(idUser: idFollowing);
    notifyListeners();
  }

  getMyPosts({required BuildContext context}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url = Uri.parse(base + 'users/get/user/${userMini.id}/posts/my/$idUser');
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("getMyPostsUser: " + response.statusCode.toString());
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
    print("updateLikePostUser: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getMyPosts(context: context);
        notifyListeners();
        load = false;
        notifyListeners();
        ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
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

  // removePost(
  //     {required BuildContext context,
  //     required String idPost,
  //     required BuildContext contextScreenComment,
  //     required bool screenComment}) async {
  //   load = true;
  //   notifyListeners();
  //   String id = await getId();
  //   var url = Uri.parse(base + 'posts/delete/post/$idPost/user/$id');
  //   var response = await http.delete(
  //     url,
  //     headers: {
  //       "Accept": "application/json; charset=utf-8",
  //       "content-type": "application/json; charset=utf-8"
  //     },
  //   );
  //   // ignore: avoid_print
  //   print("removePost: " + response.statusCode.toString());
  //   switch (response.statusCode) {
  //     case 200:
  //       if (screenComment) {
  //         Navigator.pop(contextScreenComment);
  //       }
  //       getMyPosts(context: context);
  //       ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
  //       break;
  //     default:
  //       load = false;
  //       notifyListeners();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Try again later')),
  //       );
  //       break;
  //   }
  // }

  returnPostWidget({required Map post, required bool screenComment, required BuildContext contextPage}) {
    // ignore: avoid_print
    switch (post["typePost"]) {
      case TypePost.UPDATE:
        return UpdatePostWidget2(
          postUpdateMini: PostUpdateMini.fromMap(map: post),
          screenComment: screenComment,
          screenUser: true,
          contextPage: contextPage,
        );
      default:
    }
  }

  isBlocked({required String idUser}) async {
    blocked = false;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/check/blocked/user/$id/blocked/$idUser');
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("isBlocked: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        blocked = item;
        notifyListeners();
        break;
    }
  }

  addBlocke({required String idUser, required BuildContext context}) async {
    blocked = false;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/put/add/blocked/user/$id/blocked/$idUser');
    var response = await http.put(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("addBlocke: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        blocked = true;
        notifyListeners();
        getProfile(idUser: idUser, context: context);
        checkFollowing(idUser: idUser);
        break;
    }
  }

  removeBlocke({required String idUser, required BuildContext context}) async {
    blocked = false;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/put/remove/blocked/user/$id/blocked/$idUser');
    var response = await http.put(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("removeBlocke: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        blocked = false;
        notifyListeners();
        break;
    }
  }

  showOptionsUserBottomSheet({required BuildContext contextPageUser, required String idUser}) async {
    String id = await getId();
    showModalBottomSheet<dynamic>(
        //isScrollControlled: true,
        context: contextPageUser,
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
                          blocked ? removeBlocke(idUser: idUser, context: context) : addBlocke(idUser: idUser, context: context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.block),
                              const SizedBox(
                                width: 8.0,
                              ),
                              blocked
                                  ? Text(
                                      'Unlock',
                                      style: TextStyle(
                                        fontSize: theme.sizeText,
                                        letterSpacing: theme.letterSpacingText,
                                        color: theme.title,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  : Text(
                                      'Block',
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
                          ReportDTO reportDTO = ReportDTO(
                            id: null,
                            levelReport: LevelReport.USER,
                            idReported: idUser,
                            typeReport: null,
                            idAuthor: id,
                            release: DateTime.now().toString(),
                          );
                          showOptionsReport(contextPageUser: contextPageUser, reportDTO: reportDTO);
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

  showOptionsReport({required BuildContext contextPageUser, required ReportDTO reportDTO}) {
    notifyListeners();
    showDialog(
        context: contextPageUser,
        builder: (context) {
          return OptionReport(
            contextAncestor: contextPageUser,
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
                            ScopedModel.of<UserModel>(widget.contextAncestor).report(
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
