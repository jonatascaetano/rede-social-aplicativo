import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/post/update_post_entity_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(
          builder: (context, child, profile) {
        return Scaffold(
          body: Stack(
            children: [
              ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 10.0,
                      thickness: 10.0,
                      color: theme.shadow,
                    );
                  },
                  itemCount: profile.posts.length,
                  itemBuilder: (context, index) {
                    return UpdatePostEntityWidget(
                      postUpdateMini: profile.posts[index],
                      screenComment: false,
                    );
                  }),
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
