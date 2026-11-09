// Repository interface for AI Model persistence.
import '../entities/model.dart';

abstract class ModelRepository {
  /// Get all installed models.
  Future<List<AiModel>> getAll();

  /// Get the currently active model.
  Future<AiModel?> getActive();

  /// Create a new model entry.
  Future<AiModel> create(AiModel model);

  /// Update an existing model.
  Future<AiModel> update(AiModel model);

  /// Delete a model.
  Future<void> delete(int id);

  /// Set the active model.
  Future<void> setActive(int? modelId);
}
