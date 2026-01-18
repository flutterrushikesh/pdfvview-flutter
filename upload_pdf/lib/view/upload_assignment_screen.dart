import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/assignment_controller.dart';

class AssignmentUploadView extends GetView<AssignmentController> {
  const AssignmentUploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Assignment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Assignment Title"),
            const SizedBox(height: 6),
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter assignment title",
              ),
            ),

            const SizedBox(height: 16),

            Obx(
              () => OutlinedButton.icon(
                onPressed: controller.pickPdf,
                icon: const Icon(Icons.picture_as_pdf),
                label: Text(
                  controller.pdfFile.value == null
                      ? "Select PDF"
                      : "PDF Selected",
                ),
              ),
            ),

            const SizedBox(height: 30),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.uploadAssignment,
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Upload Assignment"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
