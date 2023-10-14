import 'package:flutter/cupertino.dart';
import 'package:mediaid_flutter/models/chat_model.dart';

import 'bot_api.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg}) async {
    // if (chosenModelId.toLowerCase().startsWith("gpt")) {
    //   chatList.addAll(await API.sendMessageGPT(
    //     message: msg,
    //     modelId: chosenModelId,
    //   ));
    // } else {
    //   chatList.addAll(await API.sendMessage(
    //     message: msg,
    //     modelId: chosenModelId,
    //   ));
    // }
    chatList.addAll(await bot_API.sendMessage(message:msg));
    notifyListeners();
  }
  void dispose(){
    chatList.clear();
  }
}