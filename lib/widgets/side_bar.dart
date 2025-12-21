import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text('Chats', style: Theme.of(context).textTheme.titleLarge),
        ),
        InkWell(
          child: const Icon(Icons.add),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('New Chat'),
                  content: const TextField(
                    decoration: InputDecoration(hintText: "Chat name"),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
