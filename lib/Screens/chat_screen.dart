import 'package:alpine/helpers/helpers_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(name),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [const PopupMenuItem(child: Text(''))],
            )
          ],
        ),
        body: const Column(
          children: [],
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
