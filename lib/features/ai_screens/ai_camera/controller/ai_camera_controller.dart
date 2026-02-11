import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_study/features/ai_screens/ai_camera/model/camera_model.dart';
import 'package:online_study/services/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiCameraController extends GetxController {
  Rx<File?> capturedImage = Rx<File?>(null);
  final FlutterTts flutterTts = FlutterTts();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initTts();
  }

  /// API response
  Rx<CameraModel?> cameraData = Rx<CameraModel?>(null);

  /// ---------------- IMAGE SOURCE POPUP ----------------
  void showImageSourceSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _sheetItem(
              icon: Icons.camera_alt,
              title: "Camera",
              onTap: () {
                Get.back();
                pickImage(ImageSource.camera);
              },
            ),
            const SizedBox(height: 16),
            _sheetItem(
              icon: Icons.photo_library,
              title: "Photos",
              onTap: () {
                Get.back();
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sheetItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }

  /// ---------------- PICK IMAGE ----------------
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      capturedImage.value = File(image.path);
      log('Selected image: ${image.path}');
      log('Mime: ${lookupMimeType(image.path)}');
    }
  }

  /// ---------------- RESET ----------------
  void resetImage() {
    capturedImage.value = null;
    cameraData.value = null;
  }

  /// ---------------- SEND IMAGE (DIRECT MULTIPART) ----------------
  Future<void> sendImage() async {
    if (capturedImage.value == null) {
      Get.snackbar("Error", "Please choose an image first");
      return;
    }

    try {
      isLoading.value = true;

      final file = capturedImage.value!;
      final mimeType = lookupMimeType(file.path);

      if (mimeType == null || !mimeType.startsWith('image/')) {
        Get.snackbar("Error", "Invalid image format");
        return;
      }

      /// 🔐 GET TOKEN FROM SHARED PREFERENCES
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "User not logged in");
        return;
      }

      log('Bearer Token: $token');
      log('Uploading file: ${file.path}');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiEndpoints.camera),
      );

      /// ✅ ADD AUTH HEADER
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          file.path,
          contentType: http.MediaType.parse(mimeType),
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);

        cameraData.value = CameraModel.fromJson(decoded);

        log("Parsed word: ${cameraData.value?.data?.word}");

        Get.snackbar("Success", "Image uploaded successfully");
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  /// ---------------- TEXT-TO-SPEECH ----------------
  Future<void> _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.30);
    await flutterTts.setPitch(1.0);
  }

  Future<void> speakWord(String word) async {
    if (word.isEmpty) return;
    await flutterTts.stop();
    await flutterTts.speak(word);
  }
}
