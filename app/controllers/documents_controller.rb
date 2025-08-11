class DocumentsController < ApplicationController
    
    def index
    #   @documents = current_user.documents.order(created_at: :desc)
    end
  
    # def show
    # end
  
    # def new
    #   @document = current_user.documents.new
    # end
  
    # def create
    #   @document = current_user.documents.new(document_params)
    #   if @document.save
    #     SummarizeDocumentJob.perform_later(@document.id)
    #     TagDocumentJob.perform_later(@document.id)
    #     redirect_to @document, notice: "Document uploaded! Processing..."
    #   else
    #     render :new, status: :unprocessable_entity
    #   end
    # end
  
    # def summarize
    #   SummarizeDocumentJob.perform_later(@document.id)
    #   redirect_to @document, notice: "Summarization started."
    # end
  
    # def tag
    #   TagDocumentJob.perform_later(@document.id)
    #   redirect_to @document, notice: "Tagging started."
    # end
  
    # private
  
    # def set_document
    #   @document = current_user.documents.find(params[:id])
    # end
  
    # def document_params
    #   params.require(:document).permit(:title, :file)
    # end
  end