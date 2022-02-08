import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

import 'update_profile/description_update.dart';
import 'update_profile/email_update.dart';
import 'update_profile/image_update.dart';
import 'update_profile/name_update.dart';
import 'update_profile/password_update.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(
          builder: (context, child, profile) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                'Update profile',
                style: TextStyle(
                  color: theme.title,
                  fontSize: 24.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Images',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 1.5,
                                color: theme.title,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ImageUpdate()),
                              );
                            },
                            child: Text(
                              'edit',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 1.5,
                                color: theme.subtitle,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      profile.userMini.image != null
                          ? Stack(children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: theme.shadow,
                                    image: DecorationImage(
                                      image:
                                          NetworkImage(profile.userMini.image!),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 2.0,
                                  right: 2.0,
                                  child: IconButton(
                                      onPressed: () {
                                        UserDTO userDTO = UserDTO(
                                            idUser: profile.userMini.id,
                                            name: null,
                                            email: null,
                                            password: null,
                                            image: profile.userMini.image!,
                                            description: null,
                                            place: null,
                                            privacy: null,
                                            status: null,
                                            invitation: null);
                                        profile.removeImageProfile(
                                            userDTO: userDTO, context: context);
                                      },
                                      icon: Icon(Icons.clear_rounded,
                                          color: theme.subtitle))),
                            ])
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

                      // profile.userMini.images.isNotEmpty
                      //     ? CircleAvatar(
                      //         backgroundImage: NetworkImage(
                      //             profile.userMini.images[0].toString()),
                      //         radius: 60.0,
                      //       )
                      //     : CircleAvatar(
                      //         backgroundColor: Colors.grey[300],
                      //         child: const Icon(
                      //           Icons.person,
                      //           size: 80.0,
                      //         ),
                      //         radius: 60.0,
                      //       ),

                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => ImageUpdate(
                      //                 image: profile.userMini.image,
                      //               )),
                      //     );
                      //   },
                      //   child: const Text('Edit'),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: theme.shadow,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 1.5,
                                color: theme.title,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NameUpdate(
                                          name: profile.userMini.name,
                                        )),
                              );
                            },
                            child: Text(
                              'edit',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 1.5,
                                color: theme.subtitle,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        profile.userMini.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.subtitle,
                        ),
                      ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => NameUpdate(
                      //                 name: profile.userMini.name,
                      //               )),
                      //     );
                      //   },
                      //   child: const Text('Edit'),
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // Divider(
                      //   color: theme.shadow,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Text(
                      //         'Place',
                      //         style: TextStyle(
                      //           fontSize: 19,
                      //           letterSpacing: 1.5,
                      //           color: theme.title,
                      //         ),
                      //       ),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => PlaceUpdate(
                      //                     place: profile.userMini.place,
                      //                   )),
                      //         );
                      //       },
                      //       child: Text(
                      //         'edit',
                      //         style: TextStyle(
                      //           fontSize: 19,
                      //           letterSpacing: 1.5,
                      //           color: theme.subtitle,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      // profile.userMini.place != null
                      //     ? Text(
                      //         profile.userMini.place!,
                      //         style: TextStyle(
                      //           fontSize: 16,
                      //           color: theme.subtitle,
                      //         ),
                      //       )
                      //     : Text(
                      //         'empty',
                      //         style: TextStyle(
                      //           fontSize: 16,
                      //           color: theme.subtitle,
                      //         ),
                      //       ),

                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => PlaceUpdate(
                      //                 place: profile.userMini.place,
                      //               )),
                      //     );
                      //   },
                      //   child: const Text('Edit'),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: theme.shadow,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 1.5,
                                color: theme.title,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DescriptionUpdate(
                                          description:
                                              profile.userMini.description,
                                        )),
                              );
                            },
                            child: Text(
                              'edit',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 1.5,
                                color: theme.subtitle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      profile.userMini.description != null
                          ? Text(
                              profile.userMini.description!,
                              style: TextStyle(
                                fontSize: 16,
                                color: theme.subtitle,
                              ),
                            )
                          : Text(
                              'empty',
                              style: TextStyle(
                                fontSize: 16,
                                color: theme.subtitle,
                              ),
                            ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => DescriptionUpdate(
                      //                 description: profile.userMini.description,
                      //               )),
                      //     );
                      //   },
                      //   child: const Text('Edit'),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: theme.shadow,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 1.5,
                                color: theme.title,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmailUpdate(
                                          email: profile.userMini.email,
                                        )),
                              );
                            },
                            child: Text(
                              'edit',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 1.5,
                                color: theme.subtitle,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        profile.userMini.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.subtitle,
                        ),
                      ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => EmailUpdate(
                      //                 email: profile.userMini.email,
                      //               )),
                      //     );
                      //   },
                      //   child: const Text('Edit'),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: theme.shadow,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 1.5,
                                color: theme.title,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PasswordUpdate()),
                              );
                            },
                            child: Text(
                              'edit',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 1.5,
                                color: theme.subtitle,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '******************',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.subtitle,
                        ),
                      ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const PasswordUpdate()),
                      //     );
                      //   },
                      //   child: const Text('Edit'),
                      // ),
                    ],
                  ),
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
            ));
      });
    });
  }
}
