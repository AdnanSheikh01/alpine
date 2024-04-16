import 'package:flutter/material.dart';

//////Container//////
class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Colors.black, Colors.blue.shade900, Colors.black]),
      ),
      child: child,
    );
  }
}

//////Elevated Button//////
class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      this.focusNode,
      required this.callback,
      required this.name,
      required this.child,
      required this.foreground,
      required this.background});
  final FocusNode? focusNode;
  final VoidCallback callback;
  final String name;
  final Widget? child;
  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        focusNode: focusNode,
        style: ElevatedButton.styleFrom(
            foregroundColor: foreground, backgroundColor: background),
        onPressed: callback,
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Align(alignment: Alignment.centerLeft, child: child),
        ]),
      ),
    );
  }
}
