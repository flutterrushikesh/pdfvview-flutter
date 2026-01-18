class AssignmentModel {
  final String id;
  final String title;
  final String pdfUrl;

  AssignmentModel({
    required this.id,
    required this.title,
    required this.pdfUrl,
  });

  factory AssignmentModel.fromFirestore(String id, Map<String, dynamic> data) {
    return AssignmentModel(
      id: id,
      title: data['title'] ?? '',
      pdfUrl: data['pdfUrl'] ?? '',
    );
  }
}
