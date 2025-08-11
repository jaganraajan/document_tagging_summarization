class LlmService
  # Mock LLM service that simulates API calls to a language model
  
  def self.summarize(text)
    # Simulate API delay
    sleep(1)
    
    # Mock summarization response
    word_count = text.split.length
    
    if word_count < 50
      "Brief document summarizing key points about #{extract_topic(text)}."
    elsif word_count < 200
      "This document discusses #{extract_topic(text)}. The main points include key concepts and important details that provide valuable insights into the subject matter."
    else
      "This comprehensive document explores #{extract_topic(text)} in detail. The content covers multiple aspects including background information, key findings, and practical applications. The document provides thorough analysis and presents well-researched conclusions that contribute to understanding of this topic."
    end
  rescue => e
    Rails.logger.error "LLM Summarization failed: #{e.message}"
    "Summary unavailable - processing error occurred."
  end
  
  def self.extract_tags(text)
    # Simulate API delay
    sleep(0.5)
    
    # Mock tag extraction based on common keywords
    mock_tags = []
    
    # Technology tags
    mock_tags << "technology" if text.downcase.include?("software") || text.downcase.include?("computer")
    mock_tags << "business" if text.downcase.include?("company") || text.downcase.include?("business")
    mock_tags << "research" if text.downcase.include?("study") || text.downcase.include?("research")
    mock_tags << "education" if text.downcase.include?("learn") || text.downcase.include?("education")
    mock_tags << "health" if text.downcase.include?("health") || text.downcase.include?("medical")
    
    # Fallback tags if no specific ones found
    if mock_tags.empty?
      topic = extract_topic(text)
      mock_tags = [topic.downcase, "document", "analysis"]
    end
    
    # Add some random additional tags for variety
    additional_tags = ["important", "review", "summary", "content", "information"]
    mock_tags += additional_tags.sample(2)
    
    mock_tags.uniq.join(", ")
  rescue => e
    Rails.logger.error "LLM Tag extraction failed: #{e.message}"
    "general, document, content"
  end
  
  private
  
  def self.extract_topic(text)
    # Simple topic extraction from first significant word
    words = text.split
    significant_words = words.reject { |w| w.length < 4 || common_words.include?(w.downcase) }
    significant_words.first&.capitalize || "Topic"
  end
  
  def self.common_words
    %w[this that with from they have been will would could should about where when what]
  end
end