import 'dart:convert';
import 'model_catalog_entry.dart';
import 'hardware_profile.dart';

/// Default model catalogue — curated compatible models for InhaleSkill AI.
/// Models are downloaded from Hugging Face or other trusted sources.
class ModelCatalog {
  static const List<ModelCatalogEntry> defaultModels = [
    // Lightweight model for 4GB RAM devices
    ModelCatalogEntry(
      id: 'qwen3-0.6b-q4',
      name: 'Qwen3 0.6B (Q4)',
      description: 'Ultra-lightweight model for basic chat and learning tasks.',
      url:
          'https://huggingface.co/Qwen/Qwen3-0.6B-GGUF/resolve/main/qwen3-0.6b-q4_k_m.gguf',
      sizeBytes: 420 * 1024 * 1024,
      quantization: 'Q4_K_M',
      supportedTasks: ['chat', 'learning', 'writing', 'math', 'coding'],
      minRamMb: 3072,
      recommendedRamMb: 4096,
      license: 'Apache-2.0',
      architecture: 'Qwen3',
      family: 'qwen',
    ),
    // Balanced model for 6-8GB RAM
    ModelCatalogEntry(
      id: 'qwen3-1.7b-q4',
      name: 'Qwen3 1.7B (Q4)',
      description: 'Balanced model for improved reasoning and coding.',
      url:
          'https://huggingface.co/Qwen/Qwen3-1.7B-GGUF/resolve/main/qwen3-1.7b-q4_k_m.gguf',
      sizeBytes: 980 * 1024 * 1024,
      quantization: 'Q4_K_M',
      supportedTasks: [
        'chat',
        'learning',
        'writing',
        'math',
        'coding',
        'translation',
      ],
      minRamMb: 4096,
      recommendedRamMb: 6144,
      license: 'Apache-2.0',
      architecture: 'Qwen3',
      family: 'qwen',
    ),
    // Enhanced model for 8-12GB RAM
    ModelCatalogEntry(
      id: 'qwen3-4b-q4',
      name: 'Qwen3 4B (Q4)',
      description:
          'Enhanced model for advanced reasoning, coding, and document analysis.',
      url:
          'https://huggingface.co/Qwen/Qwen3-4B-GGUF/resolve/main/qwen3-4b-q4_k_m.gguf',
      sizeBytes: 2400 * 1024 * 1024,
      quantization: 'Q4_K_M',
      supportedTasks: [
        'chat',
        'learning',
        'writing',
        'math',
        'coding',
        'translation',
        'documents',
      ],
      minRamMb: 6144,
      recommendedRamMb: 8192,
      license: 'Apache-2.0',
      architecture: 'Qwen3',
      family: 'qwen',
    ),
    // Vision model for devices with 8GB+ RAM
    ModelCatalogEntry(
      id: 'qwen2.5-vl-3b-q4',
      name: 'Qwen2.5-VL 3B (Q4)',
      description: 'Vision-language model for image understanding and OCR.',
      url:
          'https://huggingface.co/Qwen/Qwen2.5-VL-3B-GGUF/resolve/main/qwen2.5-vl-3b-q4_k_m.gguf',
      sizeBytes: 2100 * 1024 * 1024,
      quantization: 'Q4_K_M',
      supportedTasks: ['vision', 'ocr', 'image-analysis'],
      minRamMb: 8192,
      recommendedRamMb: 10240,
      license: 'Apache-2.0',
      architecture: 'Qwen2.5-VL',
      family: 'qwen-vl',
      vision: true,
    ),
  ];

  static List<ModelCatalogEntry> getModels() => defaultModels;

  static List<ModelCatalogEntry> compatibleWith(HardwareProfile hw) {
    return defaultModels.where((m) => m.compatibleWith(hw)).toList();
  }

  static ModelCatalogEntry? getById(String id) {
    for (final m in defaultModels) {
      if (m.id == id) return m;
    }
    return null;
  }

  static Map<String, dynamic> toJson(ModelCatalogEntry m) => {
    'id': m.id,
    'name': m.name,
    'description': m.description,
    'url': m.url,
    'sizeBytes': m.sizeBytes,
    'quantization': m.quantization,
    'supportedTasks': m.supportedTasks,
    'minRamMb': m.minRamMb,
    'recommendedRamMb': m.recommendedRamMb,
    'license': m.license,
    'architecture': m.architecture,
    'vision': m.vision,
    'family': m.family,
  };

  static String encodeCatalogue() =>
      jsonEncode(defaultModels.map(toJson).toList());
}
