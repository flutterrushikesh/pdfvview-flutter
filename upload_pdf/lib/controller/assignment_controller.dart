import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AssignmentController extends GetxController {
  final titleController = TextEditingController();

  Rx<File?> pdfFile = Rx<File?>(null);
  RxBool isLoading = false.obs;

  final String courseId = "flutter_beginner"; // later dynamic

  /// Pick PDF
  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      pdfFile.value = File(result.files.single.path!);
    }
  }

  /// Upload Assignment
  Future<void> uploadAssignment() async {
    if (titleController.text.isEmpty || pdfFile.value == null) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    try {
      isLoading.value = true;

      final assignmentId = FirebaseFirestore.instance
          .collection('assignments')
          .doc()
          .id;

      final storageRef = FirebaseStorage.instance.ref(
        "assignments/$courseId/$assignmentId.pdf",
      );

      await storageRef.putFile(pdfFile.value!);
      final pdfUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('assignments')
          .doc(assignmentId)
          .set({
            "title": titleController.text.trim(),
            "courseId": courseId,
            "pdfUrl": pdfUrl,
            "createdAt": Timestamp.now(),
          });

      Get.snackbar("Success", "Assignment uploaded successfully");

      titleController.clear();
      pdfFile.value = null;
    } catch (e) {
      log("Upload Failed, ${e.toString()}");
      Get.snackbar("Upload Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}
