import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_update_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';

// ignore: must_be_immutable
class ImageUpdate extends StatefulWidget {
  String? image;
  ImageUpdate({required this.image, Key? key}) : super(key: key);

  @override
  _ImageUpdateState createState() => _ImageUpdateState();
}

class _ImageUpdateState extends State<ImageUpdate> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfileModel>(
        builder: (context, child, profile) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            "Update image",
            style: TextStyle(
              color: Colors.purple,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !profile.imageIsNull
                        ? Stack(children: [
                            CircleAvatar(
                              backgroundImage: FileImage(profile.imageFile),
                              radius: 60.0,
                            ),
                            Positioned(
                                top: 1.0,
                                right: 1.0,
                                child: IconButton(
                                  onPressed: () {
                                    profile.removeImage();
                                  },
                                  icon: const Icon(Icons.clear),
                                ))
                          ])
                        : widget.image == null
                            ? CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                child: const Icon(
                                  Icons.person,
                                  size: 80.0,
                                ),
                                radius: 60.0,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(widget.image!),
                                radius: 60.0,
                              ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    !profile.imageIsNull
                        ? TextButton(
                            onPressed: () {
                              UserUpdateDTO userUpdateDTO = UserUpdateDTO(
                                  idUser: profile.userMini.id,
                                  name: null,
                                  email: null,
                                  password: null,
                                  image: null,
                                  description: null,
                                  birthDate: null,
                                  place: null,
                                  privacy: null,
                                  status: null);
                              profile.updateImage(
                                  userUpdateDTO: userUpdateDTO,
                                  context: context);
                            },
                            child: const Text("Confirm"),
                          )
                        : TextButton(
                            onPressed: () {
                              profile.loadImage();
                            },
                            child: const Text("Select"),
                          ),
                  ],
                ),
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
        ),
      );
    });
  }
}
