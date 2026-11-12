/// PDF extraction tests using Syncfusion PdfTextExtractor.
/// Test PDFs are generated programmatically via the `pdf` package.
library;

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart' as sf;

/// Generate a minimal PDF with text content on [numPages] pages.
/// Each page contains "Page N: [label]" to verify page-level extraction.
Future<Uint8List> _generatePdf({
  required int numPages,
  String label = 'Test',
}) async {
  final doc = pw.Document();

  for (int i = 0; i < numPages; i++) {
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Text('Page ${i + 1}: $label content'),
      ),
    );
  }

  return await doc.save();
}

/// Generate a PDF with one empty page followed by a text page.
Future<Uint8List> _generatePdfWithEmptyPage() async {
  final doc = pw.Document();

  // Empty page
  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => pw.Container(),
    ),
  );

  // Text page
  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => pw.Text('Second page has text content'),
    ),
  );

  return await doc.save();
}

/// Extract text using Syncfusion, returning per-page strings.
Future<List<String>> _extractPages(Uint8List bytes) async {
  final doc = sf.PdfDocument(inputBytes: bytes);
  final extractor = sf.PdfTextExtractor(doc);
  final results = <String>[];

  for (int i = 0; i < doc.pages.count; i++) {
    final text = extractor.extractText(startPageIndex: i, endPageIndex: i);
    results.add(text.trim());
  }

  doc.dispose();
  return results;
}

/// Normalize extracted text by removing line breaks for reliable assertions.
String _normalize(String text) {
  return text
      .replaceAll('\r', '')
      .replaceAll('\n', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

void main() {
  group('Syncfusion PDF text extraction', () {
    test('extracts text from single-page PDF', () async {
      final bytes = await _generatePdf(numPages: 1, label: 'Single');
      final pages = await _extractPages(bytes);

      expect(pages.length, 1);
      final normalized = _normalize(pages[0]);
      expect(normalized, contains('Page'));
      expect(normalized, contains('1'));
      expect(normalized, contains('Single'));
    });

    test('extracts text from multi-page PDF', () async {
      final bytes = await _generatePdf(numPages: 3, label: 'Multi');
      final pages = await _extractPages(bytes);

      expect(pages.length, 3);
      expect(_normalize(pages[0]), contains('Page'));
      expect(_normalize(pages[0]), contains('1'));
      expect(_normalize(pages[1]), contains('2'));
      expect(_normalize(pages[2]), contains('3'));
      for (final page in pages) {
        expect(_normalize(page), contains('Multi'));
      }
    });

    test('handles empty page followed by text page', () async {
      final bytes = await _generatePdfWithEmptyPage();
      final pages = await _extractPages(bytes);

      expect(pages.length, 2);
      expect(pages[0].isEmpty, true);
      expect(_normalize(pages[1]), contains('Second page'));
    });

    test('page count matches', () async {
      final bytes = await _generatePdf(numPages: 5);
      final doc = sf.PdfDocument(inputBytes: bytes);
      expect(doc.pages.count, 5);
      doc.dispose();
    });

    test('detects empty PDF extraction', () async {
      // A PDF with only an empty page should yield no text
      final doc = pw.Document();
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context ctx) => pw.Container(),
        ),
      );
      final bytes = await doc.save();
      final pages = await _extractPages(bytes);

      expect(pages.length, 1);
      expect(pages[0].isEmpty, true);
    });

    test('throws on invalid PDF bytes', () async {
      final invalidBytes = Uint8List.fromList([0x00, 0x01, 0x02, 0x03]);
      expect(() async => _extractPages(invalidBytes), throwsA(isA<Object>()));
    });

    test('throws on missing file path', () async {
      final missingFile = File('/tmp/nonexistent_pdf_12345.pdf');
      expect(await missingFile.exists(), false);
      expect(() async => missingFile.readAsBytes(), throwsA(anything));
    });

    test('page-aware extraction preserves page numbers', () async {
      final bytes = await _generatePdf(numPages: 4, label: 'Ordered');
      final pages = await _extractPages(bytes);

      expect(_normalize(pages[0]), contains('Page'));
      expect(_normalize(pages[0]), contains('1'));
      expect(_normalize(pages[1]), contains('2'));
      expect(_normalize(pages[2]), contains('3'));
      expect(_normalize(pages[3]), contains('4'));

      // Verify ordering: each page should NOT contain another page's label
      expect(_normalize(pages[0]), isNot(contains('Page 2')));
      expect(_normalize(pages[1]), isNot(contains('Page 1')));
    });
  });
}
