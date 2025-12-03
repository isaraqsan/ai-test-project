class AIImageModel {
  final String originalUrl;
  final List<String> generatedUrls;
  final DateTime createdAt;

  AIImageModel({
    required this.originalUrl,
    required this.generatedUrls,
    required this.createdAt,
  });

  factory AIImageModel.fromMap(Map<String, dynamic> map) {
    return AIImageModel(
      originalUrl: map['originalUrl'] ?? '',
      generatedUrls: List<String>.from(map['generatedUrls'] ?? []),
      createdAt:
          DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'originalUrl': originalUrl,
      'generatedUrls': generatedUrls,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
