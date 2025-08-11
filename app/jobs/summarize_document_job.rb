class SummarizeDocumentJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    document = Document.find(document_id)
    
    # Extract text from the document
    extracted_text = if document.content.present?
      document.content
    elsif document.file.attached?
      TextExtractionService.extract_from_file(document.file)
    else
      "No content available for summarization"
    end
    
    # Store extracted content if not already present
    if document.content.blank? && extracted_text.present?
      document.update!(content: extracted_text)
    end
    
    # Generate summary using LLM service
    summary = LlmService.summarize(extracted_text)
    
    # Update document with summary
    document.update!(summary: summary)
    
    Rails.logger.info "Document #{document.id} summarized successfully"
  rescue => e
    Rails.logger.error "Failed to summarize document #{document_id}: #{e.message}"
    document = Document.find_by(id: document_id)
    document&.update(summary: "Summarization failed - please try again")
  end
end
