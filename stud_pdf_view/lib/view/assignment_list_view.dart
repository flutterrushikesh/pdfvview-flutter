import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/assignment_controller.dart';
import 'assignment_pdf_viewer.dart';

class AssignmentListView extends GetView<StudentAssignmentController> {
  const AssignmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignments")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.assignments.isEmpty) {
          return const Center(child: Text("No assignments available"));
        }

        return ListView.builder(
          itemCount: controller.assignments.length,
          itemBuilder: (context, index) {
            final assignment = controller.assignments[index];
            return ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text(assignment.title),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.to(
                  () => PdfViewerView(
                    title: assignment.title,
                    pdfUrl: assignment.pdfUrl,
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
