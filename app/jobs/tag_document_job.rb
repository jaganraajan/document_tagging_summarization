class TagDocumentJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    document = Document.find(document_id)
    
    # Get text content for tagging
    text_to_tag = if document.content.present?
      document.content
    elsif document.file.attached?
      TextExtractionService.extract_from_file(document.file)
    else
      document.title || "No content available for tagging"
    end
    
    # Generate tags using LLM service
    tags = LlmService.extract_tags(text_to_tag)
    
    # Update document with tags
    document.update!(tags: tags)
    
    Rails.logger.info "Document #{document.id} tagged successfully with: #{tags}"
  rescue => e
    Rails.logger.error "Failed to tag document #{document_id}: #{e.message}"
    document = Document.find_by(id: document_id)
    document&.update(tags: "general, document")
  end
end
