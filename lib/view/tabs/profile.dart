import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/profile/all_workers_profile.dart';
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
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(
          builder: (context, child, profile) {
        return Scaffold(
          body: Stack(
            children: [
              profile.profileNull
                  ? Container()
                  : ListView(
                      children: [
                        profile.userMini.image != null
                            ? Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(profile.userMini.image!),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              )
                            : Container(
                                color: theme.shadow,
                                height: 200,
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 100,
                                    color: theme.emphasis,
                                  ),
                                )),

                        const SizedBox(
                          height: 16.0,
                        ),
                        // profile.userMini.image != null
                        //     ? Padding(
                        //         padding:
                        //             const EdgeInsets.fromLTRB(0, 60, 0, 0),
                        //         child: CircleAvatar(
                        //           backgroundImage: NetworkImage(
                        //               profile.userMini.image.toString()),
                        //           radius: 60.0,
                        //         ),
                        //       )
                        //     : Padding(
                        //         padding:
                        //             const EdgeInsets.fromLTRB(0, 60, 0, 0),
                        //         child: CircleAvatar(
                        //           backgroundColor: Colors.grey[300],
                        //           child: const Icon(
                        //             Icons.person,
                        //             size: 80.0,
                        //           ),
                        //           radius: 60.0,
                        //         ),
                        //       ),
                        // const SizedBox(
                        //   height: 16.0,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        profile.userMini.name,
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: theme.title,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2.0,
                                      ),
                                      profile.userMini.checked
                                          ? Icon(
                                              Icons.check_circle_outlined,
                                              color: theme.emphasis,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: theme.button,
                              elevation: 0.0,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateProfile()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: theme.buttonMain,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  'edit profile',
                                  style: TextStyle(
                                    fontSize: 19,
                                    letterSpacing: 1.0,
                                    color: theme.buttonText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        Text(
                                          'Followers',
                                          style: TextStyle(
                                              fontSize: 16,
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.normal,
                                              color: theme.subtitle),
                                        ),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          profile.userMini.quantityFollowers
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.normal,
                                              color: theme.subtitle),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Following(
                                                      idUser:
                                                          profile.userMini.id,
                                                      isUser: true,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Following',
                                            style: TextStyle(
                                                letterSpacing: 1.0,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: theme.subtitle),
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          Text(
                                            profile.userMini.quantityFollowing
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.normal,
                                                color: theme.subtitle),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        profile.userMini.place != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.place,
                                      color: theme.detail,
                                    ),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      profile.userMini.place!,
                                      style: const TextStyle(
                                        fontSize: 19,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        profile.userMini.description != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  profile.userMini.description!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                    color: theme.subtitle,
                                  ),
                                ),
                              )
                            : Container(),

                        profile.workers.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'View all works',
                                        style: TextStyle(
                                            fontSize: 19, color: theme.title),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AllWorkersProfile(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: theme.title,
                                        size: 24.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),

                        // profile.workers.isNotEmpty
                        //     ? Row(
                        //         children: [
                        //           const Text(
                        //             'Workers',
                        //             style: TextStyle(
                        //               fontSize: 18,
                        //               letterSpacing: 2.0,
                        //             ),
                        //           ),
                        //           const SizedBox(
                        //             width: 24.0,
                        //           ),
                        //           IconButton(
                        //               onPressed: () {},
                        //               icon: const Icon(Icons.arrow_forward)),
                        //         ],
                        //       )
                        //     : Container(),
                        profile.workers.isNotEmpty
                            ? SizedBox(
                                height: 280,
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
                                height: 24.0,
                              )
                            : Container(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: LanguageModel()
                                .typeEntitiesMini
                                .map(
                                  (e) => EntityMiniProfile(
                                    index: LanguageModel()
                                        .typeEntitiesMini
                                        .indexOf(e),
                                    isUser: true,
                                    idUser: '',
                                  ),
                                )
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
    });
  }
}
