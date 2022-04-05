import 'package:flutter/material.dart';

class AddedPost extends StatelessWidget {
  const AddedPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: TextField(
        minLines: 1,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          label: const Text("comment"),
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}
