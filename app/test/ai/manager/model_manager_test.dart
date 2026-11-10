/// ModelManager unit tests - simplified
library;

import 'package:flutter_test/flutter_test.dart';

import 'package:inhaleskill_ai/ai/manager/model_manager.dart';

void main() {
  group('DownloadProgress', () {
    test('progressPercent formats correctly', () {
      const progress = DownloadProgress(modelId: 'test', progress: 0.333);
      expect(progress.progressPercent, '33.3%');
    });

    test('progressPercent shows 100.0%', () {
      const progress = DownloadProgress(modelId: 'test', progress: 1.0);
      expect(progress.progressPercent, '100.0%');
    });

    test('sizeInfo formats bytes', () {
      const progress = DownloadProgress(
        modelId: 'test',
        progress: 0.5,
        bytesDownloaded: 512000,
        totalBytes: 1024000,
      );
      expect(progress.sizeInfo, isNotNull);
      expect(progress.sizeInfo!, contains('/'));
    });

    test('sizeInfo is null when bytes not provided', () {
      const progress = DownloadProgress(modelId: 'test', progress: 0.5);
      expect(progress.sizeInfo, isNull);
    });

    test('formats GB correctly', () {
      const progress = DownloadProgress(
        modelId: 'test',
        progress: 0.5,
        bytesDownloaded: 1500000000,
        totalBytes: 3000000000,
      );
      expect(progress.sizeInfo, isNotNull);
      expect(progress.sizeInfo!, contains('GB'));
    });

    test('formats MB correctly', () {
      const progress = DownloadProgress(
        modelId: 'test',
        progress: 0.5,
        bytesDownloaded: 52428800,
        totalBytes: 104857600,
      );
      expect(progress.sizeInfo, isNotNull);
      expect(progress.sizeInfo!, contains('MB'));
    });

    test('isComplete defaults to false', () {
      const progress = DownloadProgress(modelId: 'test', progress: 0.5);
      expect(progress.isComplete, false);
    });

    test('error field is captured', () {
      const progress = DownloadProgress(
        modelId: 'test',
        progress: 0.0,
        error: 'Download failed',
      );
      expect(progress.error, 'Download failed');
    });

    test('status field is captured', () {
      const progress = DownloadProgress(
        modelId: 'test',
        progress: 0.5,
        status: 'Downloading...',
      );
      expect(progress.status, 'Downloading...');
    });
  });
}
