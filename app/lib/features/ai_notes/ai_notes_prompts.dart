/// AI Notes generation prompt templates.
/// Provides structured prompts for different note types.
library;

/// Prompt templates for AI-generated notes.
class AiNotesPrompts {
  AiNotesPrompts._();

  /// Study notes prompt - generates structured notes with headings, key points, and examples.
  static const String studyNotes = '''You are an expert educational content creator. Generate comprehensive study notes for the following topic.

Format your response with:
1. Clear headings and subheadings
2. Key concepts explained in detail
3. Important definitions highlighted
4. Relevant examples to illustrate concepts
5. Summary of main takeaways

Make the notes educational, well-organized, and easy to understand for students.

Topic/Content:
{content}

Generate study notes:''';

  /// Summary notes prompt - generates condensed overview.
  static const String summaryNotes = '''You are an expert summarizer. Create a concise summary of the following content.

Your summary should:
1. Capture the main ideas in 3-5 paragraphs
2. Highlight the most important concepts
3. Omit unnecessary details
4. Be clear and coherent

Content:
{content}

Generate summary notes:''';

  /// Revision notes prompt - generates bullet points for quick review.
  static const String revisionNotes = '''You are an expert at creating revision materials. Generate quick revision notes for the following topic.

Format your response as:
1. Bullet points only
2. Key facts and formulas
3. Important dates/names (if applicable)
4. Common mistakes to avoid
5. Quick memory tips or mnemonics

Keep it concise - suitable for last-minute review.

Topic/Content:
{content}

Generate revision notes:''';

  /// System prompt for note generation.
  static const String systemPrompt = '''You are an AI learning assistant specialized in creating educational notes. 
Your goal is to help students learn effectively by providing clear, accurate, and well-structured notes.
Always format your output in Markdown for better readability.
Use bold text for key terms, lists for organization, and headers for sections.''';

  /// Generate prompt with content inserted.
  static String buildPrompt(String template, String content) {
    return template.replaceAll('{content}', content);
  }

  /// Get prompt by type.
  static String getPromptByType(String type, String content) {
    switch (type.toLowerCase()) {
      case 'study':
        return buildPrompt(studyNotes, content);
      case 'summary':
        return buildPrompt(summaryNotes, content);
      case 'revision':
        return buildPrompt(revisionNotes, content);
      default:
        return buildPrompt(studyNotes, content);
    }
  }
}
