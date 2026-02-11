import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:online_study/global/services/recording_service.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:online_study/services/network_caller.dart';

class AiRolePlayTalkController extends GetxController {
  final isLoading = false.obs;
  final conversationId = ''.obs;
  final step = 1.obs;

  // ৫ বার কথা বলার লিমিট ম্যানেজ করার জন্য
  final userTalkCount = 0.obs;
  final int maxTalkLimit = 5;

  // চ্যাট হিস্ট্রি লিস্ট
  final RxList<Map<String, String>> messages = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    startRolePlayTalk();
  }

  /// কথোপকথন শুরু করা
  Future<void> startRolePlayTalk() async {
    isLoading.value = true;
    try {
      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.aiRolePlayAudio,
        body: {},
      );

      if (response.isSuccess) {
        final data = response.responseData;
        conversationId.value = data?['conversation_id'] ?? '';
        String initialMsg = data?['ai_message'] ?? '';
        
        if (initialMsg.isNotEmpty) {
          messages.add({"role": "ai", "text": initialMsg});
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// ইউজারের মেসেজ প্রসেস করা
  Future<void> processUserMessage(String text) async {
    if (text.isEmpty || userTalkCount.value >= maxTalkLimit) return;

    // ইউজার কথা বলা মাত্রই কাউন্টার বাড়ানো
    userTalkCount.value++;
    messages.add({"role": "user", "text": text});
    isLoading.value = true;

    try {
      final response = await NetworkCaller().postRequest(
        url: ApiEndpoints.aiRolePlayResponse,
        body: {
          'conversation_id': conversationId.value,
          'user_message': text,
        },
      );

      if (response.isSuccess) {
        final data = response.responseData;
        String aiReply = data?['ai_message'] ?? '';
        if (aiReply.isNotEmpty) {
          messages.add({"role": "ai", "text": aiReply});
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  /* ================= Recording Logic ================= */
  final _recordingService = RecordingService();
  StreamSubscription<Duration>? _recordingSub;
  final Rxn<Duration> _recordingDuration = Rxn<Duration>();
  String? _recordedPath;
  RxBool isRecording = false.obs;

  Future<void> startRecording() async {
    if (userTalkCount.value >= maxTalkLimit) return; // ৫ বারের বেশি হলে কাজ করবে না
    
    try {
      isRecording.value = true;
      await _recordingService.startRecording();
      _recordingSub?.cancel();
      _recordingSub = _recordingService.recordingStream.listen((duration) {
        _recordingDuration.value = duration;
      });
    } catch (e) {
      Logger().e("Start Recording Error: $e");
    }
  }

  Future<void> stopRecording(BuildContext context) async {
    try {
      _recordingSub?.cancel();
      final path = await _recordingService.stopRecording();
      isRecording.value = false;

      if (path != null) {
        _recordedPath = path;
        await _sendAudioToSTT(ApiEndpoints.specToText);
      }
    } catch (e) {
      Logger().e("Stop Recording Error: $e");
    }
  }

  Future<void> _sendAudioToSTT(String apiUrl) async {
    if (_recordedPath == null) return;
    isLoading.value = true;

    try {
      final response = await NetworkCaller().sendAudioToAI(apiUrl, _recordedPath!);
      if (response.isSuccess) {
        String transcribedText = response.responseData?['text'] ?? '';
        if (transcribedText.isNotEmpty) {
          await processUserMessage(transcribedText);
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}