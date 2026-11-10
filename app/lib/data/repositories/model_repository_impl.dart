// Drift implementation of ModelRepository.
import 'package:drift/drift.dart';
import '../../database/database.dart' as db;
import '../../domain/entities/model.dart' as domain;
import '../../domain/repositories/model_repository.dart';

class ModelRepositoryImpl implements ModelRepository {
  final db.AppDatabase _database;

  ModelRepositoryImpl(this._database);

  domain.AiModel _mapToEntity(db.AppModel data) {
    return domain.AiModel(
      id: data.id,
      name: data.name,
      filePath: data.filePath,
      quantization: data.quantization,
      sizeBytes: data.sizeBytes,
      architecture: data.architecture,
      isActive: data.isActive,
      installedAt: data.installedAt,
    );
  }

  @override
  Future<List<domain.AiModel>> getAll() async {
    final query = _database.select(_database.appModels)
      ..orderBy([(m) => OrderingTerm.desc(m.installedAt)]);
    final results = await query.get();
    return results.map(_mapToEntity).toList();
  }

  @override
  Future<domain.AiModel?> getActive() async {
    final query = _database.select(_database.appModels)
      ..where((m) => m.isActive.equals(true));
    final result = await query.getSingleOrNull();
    return result != null ? _mapToEntity(result) : null;
  }

  @override
  Future<domain.AiModel> create(domain.AiModel model) async {
    final companion = db.AppModelsCompanion(
      name: Value(model.name),
      filePath: Value(model.filePath),
      quantization: Value(model.quantization),
      sizeBytes: Value(model.sizeBytes),
      architecture: Value(model.architecture),
      isActive: Value(model.isActive),
      installedAt: Value(model.installedAt ?? DateTime.now()),
    );
    final id = await _database.into(_database.appModels).insert(companion);
    return model.copyWith(id: id);
  }

  @override
  Future<domain.AiModel> update(domain.AiModel model) async {
    if (model.id == null) {
      throw ArgumentError('Cannot update model without ID');
    }
    final companion = db.AppModelsCompanion(
      id: Value(model.id!),
      name: Value(model.name),
      filePath: Value(model.filePath),
      quantization: Value(model.quantization),
      sizeBytes: Value(model.sizeBytes),
      architecture: Value(model.architecture),
      isActive: Value(model.isActive),
      installedAt: Value(model.installedAt ?? DateTime.now()),
    );
    await _database.update(_database.appModels).replace(companion);
    return model;
  }

  @override
  Future<void> delete(int id) async {
    await (_database.delete(_database.appModels)
      ..where((m) => m.id.equals(id))).go();
  }

  @override
  Future<void> setActive(int? modelId) async {
    // Deactivate all
    await (_database.update(_database.appModels)..where(
      (m) => m.id.isNotNull(),
    )).write(const db.AppModelsCompanion(isActive: Value(false)));

    // Activate the selected one
    if (modelId != null) {
      await (_database.update(_database.appModels)..where(
        (m) => m.id.equals(modelId),
      )).write(const db.AppModelsCompanion(isActive: Value(true)));
    }
  }
}
