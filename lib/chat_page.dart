import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => AiChatPageState();
}

class AiChatPageState extends State<AiChatPage> {
  String apiKey = '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';
  List<Chat> currentChatHisory = [];
  TextEditingController textEditingController = TextEditingController();
  bool isWaiting = false;
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  bool isKeyboardVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      //on vertical drag start, hide keyboard
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        isKeyboardVisible = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (scrollController.positions.isNotEmpty) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 1000,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
    isKeyboardVisible ? focusNode.requestFocus() : focusNode.unfocus();
    return Stack(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 130,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 50),
                    for (var index = 0;
                        index < currentChatHisory.length;
                        index++)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment:
                            currentChatHisory[index].role == 'user'
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * .6,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: currentChatHisory[index].role == 'user'
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(currentChatHisory[index].content,
                                    textAlign:
                                        currentChatHisory[index].role == 'user'
                                            ? TextAlign.end
                                            : TextAlign.start,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
        Column(
          children: [
            isWaiting
                ? const Center(
                    child: LinearProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : const SizedBox(),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 0.5, 1],
                  colors: [
                    Colors.white.withOpacity(1),
                    Colors.white.withOpacity(.5),
                    Colors.white.withOpacity(0)
                  ],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                  child: Text("AI Chat",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))),
            ),
          ],
        ),

        //Text field
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onSubmitted: (value) async {
                    currentChatHisory.add(Chat(role: 'user', content: value));
                    textEditingController.clear();
                    isKeyboardVisible = false;
                    //send message to ai
                    isWaiting = true;
                    setState(() {});

                    currentChatHisory =
                        await aiRequest(currentChatHisory, value, apiKey);

                    setState(() {
                      isWaiting = false;
                    });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Message',
                      focusColor: Colors.white,
                      fillColor: Colors.white)),
            ),
          ),
        ),
      ],
    );
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
        content:
            decoded['choices'][0]['message']['content'].toString().trim()));
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
