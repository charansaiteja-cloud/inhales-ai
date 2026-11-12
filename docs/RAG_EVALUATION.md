# RAG Evaluation Report — InhaleSkill AI

Date: 2026-11-12

## Overview

This document evaluates the Retrieval-Augmented Generation (RAG) pipeline quality
for InhaleSkill AI, covering ingestion, chunking, embedding, retrieval, citation
accuracy, and answer reliability.

## Scope

- PDF text extraction (Syncfusion `PdfTextExtractor`)
- Chunking with page-aware citations
- Hybrid retrieval (vector + keyword)
- Unsupported-answer handling
- Test coverage

## Results

### 1. PDF Text Extraction

**Implementation**: Replaced the regex-based fallback with Syncfusion
`PdfTextExtractor`, which uses the native Syncfusion PDF parser for reliable
text extraction.

| Test | Status |
|------|--------|
| Single-page PDF | PASS |
| Multi-page PDF (3 pages) | PASS |
| Empty page followed by text page | PASS |
| Page count matches | PASS |
| Empty PDF extraction detection | PASS |
| Invalid PDF bytes | PASS (throws) |
| Missing file | PASS (throws) |
| Page-aware extraction preserves page numbers | PASS |

**Coverage**: 8/8 tests passing.

### 2. Chunking & Page Citations

- Chunk size: 512 characters (configurable via `RAGService.chunkSize`)
- Chunk overlap: 64 characters (configurable via `RAGService.chunkOverlap`)
- Each chunk retains:
  - `documentId`
  - `chunkIndex`
  - `pageNumber` (from PDF page breaks)
  - `charStart` / `charEnd` (position in original text)
  - `sectionTitle` (optional)
- Page breaks are propagated from `DocumentsProvider._extractPdfText` through
  `RAGService.addDocument(pageBreaks: ...)`

### 3. Hybrid Retrieval

- Vector similarity (cosine) weight: 0.7
- Keyword score weight: 0.3
- Minimum score threshold: 0.15
- `searchInDocument` filters by `document_id`

### 4. Unsupported-Answer Handling

`answerWithCitations` now returns an explicit "insufficient information" message
when no relevant chunks are found or the best score is below 0.15, instead of
hallucinating.

### 5. Persistence

- Chunks are stored in the Drift `document_chunks` table with full metadata
  (including `pageNumber`, `charStart`, `charEnd`, `sectionTitle`).
- On startup, `_loadExistingChunks` reads all stored chunks back into memory,
  preserving page references.

## Limitations

- Embeddings are hash-based (deterministic, 384-dim). Real semantic embeddings
  require an on-device embedding model, not yet integrated.
- Syncfusion PDF library is commercial; license registration is deferred to
  app startup (currently no license key set — trial watermark may appear in
  debug builds).
- Android physical device testing not yet performed.

## Next Steps

1. Integrate on-device embedding model for real semantic search.
2. Add Syncfusion license key in `main.dart`.
3. Test on physical Android device.
4. Add multi-document collection support.