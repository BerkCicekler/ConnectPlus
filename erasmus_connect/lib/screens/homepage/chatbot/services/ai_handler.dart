import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class AIHandler {
  final openAI = OpenAI.instance.build(
    token: "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",
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
    ),
  );

  Future<String> getResponse(String message) async {
    try {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": message})
      ], maxToken: 200, model: kChatGptTurbo0301Model);

      final response = await openAI.onChatCompletion(request: request);
      if (response != null) {
        return response.choices[0].message.content.trim();
      }

      return 'Something went wrong';
    } catch (e) {
      return 'Bad response';
    }
  }

  void dispose() {
    openAI.close();
  }
}
