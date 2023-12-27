import 'package:http/http.dart' as http;
import '../secrets/api_key.dart';
import 'oai_chat_request.dart';
import 'oai_chat_response.dart';

class OpenAiChatService {
  static final Uri chatUri = Uri.parse('https://api.openai.com/v1/chat/completions');

  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${ApiKey.openAIApiKey}',
  };

  Future<String?> request(String system,String prompt, String? model, [int maxTokens=100]) async {
    try {
      OpenAiChatRequest request = OpenAiChatRequest(model: model, maxTokens: maxTokens, messages: [Message(role: "system", content: system),Message(role: "user", content: prompt)]);
      if (prompt.isEmpty) {
        return null;
      }
      http.Response response = await http.post(
        chatUri,
        headers: headers,
        body: request.toJson(),
      );
      OpenAiChatResponse chatResponse = OpenAiChatResponse.fromResponse(response);
      print(chatResponse.choices?[0].message?.content);
      return chatResponse.choices?[0].message?.content;
    } catch (e) {
      print("error $e");
    }
    return null;
  }
}