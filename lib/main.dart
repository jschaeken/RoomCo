import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomco/chat_page.dart';
import 'package:roomco/login_page.dart';
import 'package:roomco/text_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => TextProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        colorScheme: const ColorScheme.light().copyWith(primary: Colors.black),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'RoomCo', roomNumber: '504'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.roomNumber});

  final String title;
  final String? roomNumber;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool activeAnouncement = true;
  int currentIndex = 0;
  String currentPinnedAnnouncemnt = 'Do the dishes!';
  String currentAnnouncement = 'Latest Announcment';
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          elevation: 0,
          actions: currentIndex == 0
              ? [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          activeAnouncement = !activeAnouncement;
                        });
                      },
                      icon: const Icon(Icons.restart_alt)),
                  //Add pinned announcent button
                  IconButton(
                      onPressed: () async {
                        addAnnouncment(context).then((value) {
                          if (value.announcement.isNotEmpty) {
                            if (value.isPinned) {
                              currentPinnedAnnouncemnt = value.announcement;
                            } else {
                              currentAnnouncement = value.announcement;
                            }
                            setState(() {});
                          }
                        });
                      },
                      icon: const Icon(Icons.add)),
                ]
              : [],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Text(
                  'RoomCo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Announcements'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('AI Chat'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Rate your roomate'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              //settings
              ListTile(
                title: const Text('Settings'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              //logout
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                currentIndex = index;
                pageController.jumpToPage(index);
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'AI Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: currentIndex,
            selectedItemColor: Colors.black),
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                      width: double.infinity,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      // height: 78,
                      width: MediaQuery.of(context).size.width * .85,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 4)),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              child: ListTile(
                                  onTap: () => {},
                                  //pinned icon
                                  leading: const Icon(Icons.push_pin,
                                      color: Colors.black, size: 30),
                                  title: Text(currentPinnedAnnouncemnt,
                                      style: const TextStyle(fontSize: 25)),
                                  subtitle: const Text('From Jacques'),
                                  trailing: const CircleAvatar(
                                    backgroundColor: Colors.amber,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                    //A box for announcements
                    activeAnouncement
                        ? Container(
                            alignment: Alignment.topCenter,
                            height: 130,
                            width: MediaQuery.of(context).size.width * .85,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 4)),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(currentAnnouncement,
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.black)),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      const Text("From Jacques",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      //Icons for history and notifications
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.history,
                                            color: Colors.white),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.notifications,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          )
                        : Container(
                            alignment: Alignment.topCenter,
                            height: 130,
                            width: 400,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 4)),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text("No Recent Announcements",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.grey)),
                                ),
                                const Spacer(),
                                Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(children: [
                                      //Icons for history and notifications
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.history,
                                            color: Colors.white),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.notifications,
                                            color: Colors.white),
                                      ),
                                      //add announcement button
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.add_circle),
                                          color: Colors.white,
                                          iconSize: 30),
                                    ])),
                              ],
                            ),
                          ),
                    const SizedBox(height: 5),
                  ],
                ),
                const AiChatPage(),
                const Center(child: Text('Profile Page')),
              ]),
        ));
  }
}

Future<List<Chat>> aiRequest(
  List<Chat> chatHistory,
  String text,
  String apiKey,
) async {
  String endpoint = 'https://api.openai.com/v1/chat/completions';
  HttpClient httpClient = HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(endpoint));
  request.headers.set('Content-Type', 'application/json');
  request.headers.set('Authorization', 'Bearer $apiKey');
  chatHistory.add(Chat(role: 'user', content: text));
  String payload = jsonEncode({
    // 'prompt': text,
    'model': 'gpt-3.5-turbo',
    'messages': [
      ...chatHistory.map((e) => {
            "role": e.role,
            "content": e.content,
          })
    ]
  });
  request.add(utf8.encode(payload));

  //Send the request
  HttpClientResponse response = await request.close();
  httpClient.close();
  String responseBody = await response.transform(utf8.decoder).join();

  final decoded = jsonDecode(responseBody);
  log(decoded.toString());
  if (decoded['choices'][0]['message']['content'] == null) {
    // return 'An error has occured while processing your request. Try checking your API key to see if it is correct.';
    chatHistory.add(Chat(
        role: 'assistant',
        content:
            'An error has occured while processing your request. Try checking your API key to see if it is correct.'));
  } else {
    chatHistory.add(Chat(
        role: 'assistant',
        content: decoded['choices'][0]['message']['content']));
  }
  for (var i = 0; i < chatHistory.length; i++) {
    print('${chatHistory[i].role}: ${chatHistory[i].content}');
  }
  return chatHistory;
}

class Chat {
  String role;
  String content;

  Chat({required this.role, required this.content});
}

Future<Announcement> addAnnouncment(BuildContext context) async {
  //show dialog box
  //text editing controller
  final announcementController = TextEditingController();
  FocusNode announcementFocusNode = FocusNode();
  bool isPinned = false;
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        announcementFocusNode.requestFocus();
        return StatefulBuilder(
            builder: (context, setState) => WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    title: const Text("Add Announcement"),
                    content: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          TextField(
                            focusNode: announcementFocusNode,
                            controller: announcementController,
                            decoration: const InputDecoration(
                                hintText: "Enter Announcement"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Pin Announcement"),
                              Switch.adaptive(
                                  value: isPinned,
                                  onChanged: (value) {
                                    isPinned = value;
                                    setState(() {});
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          //add announcement to database
                          Navigator.of(context).pop(Announcement(
                              announcementController.text,
                              "Jacques",
                              isPinned));
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ));
      });
  return Announcement(announcementController.text, "Jacques", isPinned);
}

class Announcement {
  final String announcement;
  final String author;
  final bool isPinned;

  Announcement(this.announcement, this.author, this.isPinned);
}

//Annuncements -> Preset Announcement Buttons

//Chat -> Repy to announcemnets

//Profile -> User Profile

//Rate your roomate
