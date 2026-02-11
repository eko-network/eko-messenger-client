import 'package:ecp/ecp.dart';
import 'package:eko_messenger/screens/chat/adaptive_chat_layout.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final Person person;
  const Avatar({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: kConversationAvatarRadius,
      backgroundImage: person.profilePicture != null
          ? NetworkImage(person.profilePicture.toString())
          : null,
      child: person.profilePicture == null
          ? Text(person.preferredUsername[0])
          : null,
    );
  }
}
