import 'dart:convert';

import 'package:alpine/Screens/post_model.dart';
import 'package:alpine/helpers/helpers_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  List data = [
    ['Adnan', "Hii"],
    ['Alam', "Assalamu Alaikum"],
    ['Sayed', "Kya Haal Hai?"],
    ['Ruman', "What's up?"],
    // ['Pikla', 'I Love you']
  ];
  int _index = 0;
  bool click = true;

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PostModel> postList = [];
  Future<List<PostModel>> getPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    }
    return postList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              _index = value;
            });
          },
          children: [
            //
            //HomePage
            MyContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: getPosts(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: postList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Title',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(postList[index].title.toString()),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Description',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(postList[index].body.toString()),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  )
                  // SizedBox(height: MediaQuery.of(context).size.height / 14),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 25, right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       const Flexible(
                  //         child: Text(
                  //           'Welcome, \nAdnan',
                  //           style: TextStyle(fontSize: 30, color: Colors.white),
                  //         ),
                  //       ),
                  //       IconButton(
                  //         onPressed: () {
                  //           FirebaseAuth.instance.signOut();
                  //           Navigator.pushAndRemoveUntil(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => const LoginPage()),
                  //               (route) => false);
                  //         },
                  //         icon: const Icon(
                  //           Icons.logout,
                  //           color: Colors.white,
                  //           size: 30,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     physics: const BouncingScrollPhysics(),
                  //     itemCount: data.length,
                  //     itemBuilder: (context, index) => Card(
                  //       color: Theme.of(context).colorScheme.background,
                  //       child: ListTile(
                  //         onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => ChatScreen(
                  //                         name: data[index][0],
                  //                       )));
                  //         },
                  //         leading: const CircleAvatar(),
                  //         title: Text(
                  //           data[index][0],
                  //           style: TextStyle(
                  //               color: Theme.of(context).colorScheme.primary),
                  //         ),
                  //         subtitle: Text(data[index][1],
                  //             style: TextStyle(
                  //                 color:
                  //                     Theme.of(context).colorScheme.secondary)),
                  //         trailing: Text(
                  //           '10:35 AM',
                  //           style: TextStyle(
                  //               color: Theme.of(context).colorScheme.primary),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            //
            // Search Page
            MyContainer(
                child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(color: Colors.white))),
                  ),
                )
              ],
            )),
            //
            // Cart Page
            const MyContainer(
              child: Center(
                child: Text('Cart'),
              ),
            ),
            //
            // Me Page
            MyContainer(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false);
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.width / 6,
        child: GNav(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          gap: 8,
          selectedIndex: _index,
          onTabChange: (value) {
            setState(() {
              _controller.jumpToPage(value);
            });
          },
          activeColor: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.background,
          tabs: [
            GButton(
              padding: const EdgeInsets.all(12),
              icon: CupertinoIcons.chat_bubble_2,
              iconColor: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              backgroundGradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Colors.black, Colors.grey.shade900, Colors.black]),
              text: 'Chat',
            ),
            GButton(
              padding: const EdgeInsets.all(12),
              icon: Icons.search,
              iconColor: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              text: 'Search',
              backgroundGradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Colors.black, Colors.grey.shade900, Colors.black]),
            ),
            GButton(
              padding: const EdgeInsets.all(12),
              icon: Icons.call,
              iconColor: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              text: 'Calls',
              backgroundGradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Colors.black, Colors.grey.shade900, Colors.black]),
            ),
            GButton(
              padding: const EdgeInsets.all(12),
              icon: Icons.account_circle,
              iconColor: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              backgroundGradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Colors.black, Colors.grey.shade900, Colors.black]),
              text: 'Me',
            )
          ],
        ),
      ),
    );
  }
}
