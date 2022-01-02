import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/view/update_profile/image_update.dart';
import 'package:social_network_application/view/update_profile/place_update.dart';
import 'package:social_network_application/view/update_profile/description_update.dart';
import 'package:social_network_application/view/update_profile/name_update.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfileModel>(
        builder: (context, child, profile) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text(
              'Update profile',
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const Text(
                      'Image',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    profile.userMini.image != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(profile.userMini.image.toString()),
                            radius: 60.0,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              size: 80.0,
                            ),
                            radius: 60.0,
                          ),
                    const SizedBox(
                      height: 4,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageUpdate(
                                    image: profile.userMini.image,
                                  )),
                        );
                      },
                      child: const Text('Edit'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      profile.userMini.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NameUpdate(
                                    name: profile.userMini.name,
                                  )),
                        );
                      },
                      child: const Text('Edit'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Place',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    profile.userMini.place != null
                        ? Text(
                            profile.userMini.place!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        : const Text(
                            'empty',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                    const SizedBox(
                      height: 4,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlaceUpdate(
                                    place: profile.userMini.place,
                                  )),
                        );
                      },
                      child: const Text('Edit'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    profile.userMini.description != null
                        ? Text(
                            profile.userMini.description!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        : const Text(
                            'empty',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                    const SizedBox(
                      height: 4,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescriptionUpdate(
                                    description: profile.userMini.description,
                                  )),
                        );
                      },
                      child: const Text('Edit'),
                    ),
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
  }
}
