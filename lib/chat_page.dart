import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:roomco/text_provider.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage(
      {super.key, required this.selectedModel, this.shouldKeepAlive = true});

  final String selectedModel;
  final bool shouldKeepAlive;

  @override
  State<AiChatPage> createState() => AiChatPageState();
}

class AiChatPageState extends State<AiChatPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.shouldKeepAlive;

  String apiKey = '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';
  List<Chat> currentChatHisory = [];
  TextEditingController textEditingController = TextEditingController();
  bool isWaiting = false;
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  bool isKeyboardVisible = true;
  String newRequestText = 'count to 10 1 by 1';
  String streamResponse = '';
  late String selectedModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedModel = widget.selectedModel;
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
    super.build(context);
    if (!widget.shouldKeepAlive) {
      setState(() {
        currentChatHisory = [];
        textEditingController = TextEditingController();
        isWaiting = false;
      });
    }
    isKeyboardVisible ? focusNode.requestFocus() : focusNode.unfocus();
    return Stack(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 8.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 50),
                    for (var index = 0;
                        index < currentChatHisory.length;
                        index++)
                      ChatBubble(
                          currentChatHisory: currentChatHisory, index: index),
                  ],
                ),
              ),
            ),
          ),
          //Text field
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, bottom: 8.0, top: 6.0),
              child: TextField(
                onTapOutside: (event) => {
                  isKeyboardVisible = false,
                  focusNode.unfocus(),
                  setState(() {})
                },
                controller: textEditingController,
                focusNode: focusNode,
                onSubmitted: (value) async {
                  await handleSubmitted(value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Message',
                  focusColor: Colors.white,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
        ]),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: IgnorePointer(
            child: Column(
              children: [
                Consumer<TextProvider>(
                  builder: (_, provider, child) => provider.isWaiting
                      ? const Center(
                          child: LinearProgressIndicator(
                            color: Colors.blue,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
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
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  currentChatHisory = [];
                });
              },
              child: const Text(
                'Clear Chat',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  handleSubmitted(String text) async {
    currentChatHisory.add(Chat(role: 'user', content: text));

    context.read<TextProvider>().isWaiting = true;
    setState(() {});

    textEditingController.clear();
    isKeyboardVisible = false;
    scrollController.jumpTo(scrollController.position.maxScrollExtent);

    aiRequest(currentChatHisory, newRequestText, apiKey, true, (text) {
      log('model: $selectedModel');
      if (currentChatHisory.last.role != 'assistant') {
        context.read<TextProvider>().setText('');
        currentChatHisory.add(createNewChat('assistant', text));
        context.read<TextProvider>().isWaiting = false;
        setState(() {});
      }
      context.read<TextProvider>().addChunk(text);
      if (scrollController.offset + 20 <
          scrollController.position.maxScrollExtent) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      }
    },
        //on finish
        () {
      currentChatHisory.last.content = context.read<TextProvider>().text;
      log('set last content to ${context.read<TextProvider>().text}');
      setState(() {});
    }, selectedModel);
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.currentChatHisory,
    required this.index,
  });

  final List<Chat> currentChatHisory;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: currentChatHisory[index].role == 'user'
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
                  ? Colors.black
                  : Colors.blue,
              borderRadius: currentChatHisory[index].role == 'user'
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<TextProvider>(
                    builder: (_, provider, child) => Text(
                          currentChatHisory[index].role == 'user'
                              ? currentChatHisory[index].content
                              : index == currentChatHisory.length - 1
                                  ? provider.text
                                  : currentChatHisory[index].content,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ))),
          ),
        ).animate().slide(
              begin: currentChatHisory[index].role == 'user'
                  ? const Offset(1, 0)
                  : const Offset(-1, 0),
              end: const Offset(0, 0),
              delay: 200.milliseconds,
            ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

Chat createNewChat(String role, String initialText) {
  return Chat(role: role, content: initialText);
}

void aiRequest(
  List<Chat> chatHistory,
  String text,
  String apiKey,
  bool isStream,
  Function(String text) callbackNewChunk,
  VoidCallback callbackStreamEnd,
  String model,
) async {
  String endpoint = 'https://api.openai.com/v1/chat/completions';
  HttpClient httpClient = HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(endpoint));
  request.headers.set('Content-Type', 'application/json');
  request.headers.set('Authorization', 'Bearer $apiKey');
  String payload = jsonEncode({
    // 'prompt': text,
    'model': model,
    'messages': [
      ...chatHistory.map((e) => {
            "role": e.role,
            "content": e.content,
          })
    ],
    'stream': true
  });
  request.add(utf8.encode(payload));
  HttpClientResponse response = await request.close();

  //ATTMPET TO USE STREAM
  response.listen((event) {
    //parse response from list<int> to string
    String responseBody = utf8.decode(event).substring(6);
    log(responseBody);
    if (responseBody.contains('[DONE]')) {
      callbackStreamEnd();
    } else {
      var decoded = jsonDecode(responseBody);
      String? newChunk = decoded['choices'][0]['delta']['content'];

      if (newChunk != null) {
        log(newChunk);
        callbackNewChunk(newChunk);
      }
    }
  });

  httpClient.close();
}

class Chat {
  String role;
  String content;

  Chat({required this.role, required this.content});
}
