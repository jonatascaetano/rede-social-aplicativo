import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/auxiliar/language_model.dart';
import 'package:social_network_application/scoped_model/user_model.dart';
import 'package:social_network_application/view/profile/followers.dart';
import 'package:social_network_application/view/profile/following.dart';
import 'package:social_network_application/widgets/mini_profile/entities_mini_profile.dart';
import 'package:social_network_application/widgets/mini_profile/worker_mini_profile.dart';

// ignore: must_be_immutable
class User extends StatefulWidget {
  UserMini userMini;
  User({required this.userMini, Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(idUser: widget.userMini.id),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, user) {
        return Scaffold(
          body: Stack(
            children: [
              user.profileNull
                  ? Container()
                  : ListView(
                      children: [
                        //inicio da area profile
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            user.userMini.image != null
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 100, 0, 8),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          user.userMini.image.toString()),
                                      radius: 60.0,
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 100, 0, 8),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      child: const Icon(
                                        Icons.person,
                                        size: 80.0,
                                      ),
                                      radius: 60.0,
                                    ),
                                  ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.userMini.name,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2.0,
                                  ),
                                  user.userMini.checked
                                      ? Icon(
                                          Icons.check_circle_outlined,
                                          color: Colors.blue[900],
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            user.userMini.place != null
                                ? Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        user.userMini.place!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Followers(
                                                    idUser: user.userMini.id,
                                                    isUser: false,
                                                  )));
                                    },
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Followers',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          user.userMini.quantityFollowers
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Following(
                                                      idUser: user.userMini.id,
                                                      isUser: false,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Following',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          Text(
                                            user.userMini.quantityFollowing
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            user.userMini.description != null
                                ? Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 0.0, 0.0, 16.0),
                                    child: Text(
                                      user.userMini.description!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        user.showFollowButton
                            ? user.isFollowing
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          user.removeFollowing(
                                            idFollowing: user.userMini.id,
                                            context: context,
                                          );
                                        },
                                        child: const Text('Unfollow')),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          user.addFollowing(
                                            idFollowing: user.userMini.id,
                                            context: context,
                                          );
                                        },
                                        child: const Text('Follow')),
                                  )
                            : Container(),
                        user.workers.isNotEmpty
                            ? SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: user.workers.length,
                                    itemBuilder: (context, index) {
                                      return WorkerMiniProfile(
                                        workerMini: user.workers[index],
                                        isUser: false,
                                      );
                                    }),
                              )
                            : Container(),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: LanguageModel()
                                .typeEntities
                                .map((e) => EntityMiniProfile(
                                    index: LanguageModel()
                                        .typeEntities
                                        .indexOf(e)))
                                .toList(),
                          ),
                        ),
                        //final da area profile

                        //inicio area post
                      ],
                    ),
              user.load
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
      }),
    );
  }
}
