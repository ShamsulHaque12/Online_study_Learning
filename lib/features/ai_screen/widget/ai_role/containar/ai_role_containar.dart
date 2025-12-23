import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AiRoleContainar extends GetxController {
  var recognizedText = "".obs;
  var isRecording = false.obs;

  late stt.SpeechToText speech;

  /// chatMessages -> list of Map {"sender": "user"/"ai", "text": "..."}
  var chatMessages = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    speech = stt.SpeechToText();
  }

  /// Start recording
  Future<void> startRecording() async {
    recognizedText.value = "";
    isRecording.value = true;

    bool available = await speech.initialize(
      onStatus: (status) {
        if (status == "notListening") stopRecording();
      },
    );

    if (available) {
      speech.listen(
        listenMode: stt.ListenMode.dictation,
        partialResults: true,
        onResult: (result) {
          recognizedText.value = result.recognizedWords;
        },
      );
    }
  }

  /// Stop recording and add user + AI placeholder
  Future<void> stopRecording() async {
    if (!isRecording.value) return;

    await speech.stop();
    isRecording.value = false;

    final text = recognizedText.value.trim();
    if (text.isEmpty) return;

    // Add user message on top
    chatMessages.insert(0, {"sender": "user", "text": text});

    // Add temporary AI placeholder
    chatMessages.insert(0, {"sender": "ai", "text": "typing..."});

    // Simulate AI response after delay (replace placeholder)
    Future.delayed(const Duration(seconds: 2), () {
      int aiIndex = chatMessages.indexWhere(
              (msg) => msg["sender"] == "ai" && msg["text"] == "typing...");
      if (aiIndex != -1) {
        chatMessages[aiIndex]["text"] =
        "Hello! I got your message: \"$text\""; // replace with actual AI logic
        chatMessages.refresh(); // update UI
      }
    });
  }
}
