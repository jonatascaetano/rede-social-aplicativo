import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/auxiliar/language_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/view/profile/followers.dart';
import 'package:social_network_application/view/profile/following.dart';
import 'package:social_network_application/view/profile/update_profile.dart';
import 'package:social_network_application/widgets/mini_profile/entities_mini_profile.dart';
import 'package:social_network_application/widgets/mini_profile/worker_mini_profile.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfileModel>(
        builder: (context, child, profile) {
      return Scaffold(
        body: Stack(
          children: [
            profile.profileNull
                ? Container()
                : ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          profile.userMini.image != null
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 60, 0, 0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        profile.userMini.image.toString()),
                                    radius: 60.0,
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 60, 0, 0),
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
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    profile.userMini.name,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2.0,
                                  ),
                                  profile.userMini.checked
                                      ? Icon(
                                          Icons.check_circle_outlined,
                                          color: Colors.blue[900],
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          profile.userMini.place != null
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      profile.userMini.place!,
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
                                                  idUser: profile.userMini.id,
                                                  isUser: true,
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
                                        profile.userMini.quantityFollowers
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
                                                    idUser: profile.userMini.id,
                                                    isUser: true,
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
                                          profile.userMini.quantityFollowing
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
                          profile.userMini.description != null
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 0.0, 16.0),
                                  child: Text(
                                    profile.userMini.description!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateProfile()));
                            },
                            child: const Text('edit profile')),
                      ),
                      profile.workers.isNotEmpty
                          ? SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: profile.workers.length,
                                  itemBuilder: (context, index) {
                                    return WorkerMiniProfile(
                                      workerMini: profile.workers[index],
                                      isUser: true,
                                    );
                                  }),
                            )
                          : Container(),
                      profile.workers.isNotEmpty
                          ? const SizedBox(
                              height: 16.0,
                            )
                          : Container(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: LanguageModel()
                              .typeEntitiesMini
                              .map((e) => EntityMiniProfile(
                                  index: LanguageModel()
                                      .typeEntitiesMini
                                      .indexOf(e)))
                              .toList(),
                        ),
                      )
                    ],
                  ),
            profile.load
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
    });
  }
}
