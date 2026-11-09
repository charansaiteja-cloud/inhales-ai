/// AI Model entity for the domain layer.
class AiModel {
  final int? id;
  final String name;
  final String filePath;
  final String? quantization;
  final int sizeBytes;
  final String? architecture;
  final bool isActive;
  final DateTime? installedAt;

  const AiModel({
    this.id,
    required this.name,
    required this.filePath,
    this.quantization,
    required this.sizeBytes,
    this.architecture,
    this.isActive = false,
    this.installedAt,
  });

  AiModel copyWith({
    int? id,
    String? name,
    String? filePath,
    String? quantization,
    int? sizeBytes,
    String? architecture,
    bool? isActive,
    DateTime? installedAt,
  }) {
    return AiModel(
      id: id ?? this.id,
      name: name ?? this.name,
      filePath: filePath ?? this.filePath,
      quantization: quantization ?? this.quantization,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      architecture: architecture ?? this.architecture,
      isActive: isActive ?? this.isActive,
      installedAt: installedAt ?? this.installedAt,
    );
  }
}
