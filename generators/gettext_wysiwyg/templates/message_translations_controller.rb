class MessageTranslationsController < ApplicationController
  # do not display messages when gettext_wysiwig is turned off:
  before_filter :require_gettext_wysiwyg_mode
  
  def edit
    @message_translation = MessageTranslation.new(params[:msgid])
  end
  def update
    @message_translation = MessageTranslation.new(params[:msgid])
    @message_translation.translation = params[:message_translation][:translation]
    
    if @message_translation.save
      flash[:notice] = _("Translation updated!")
    else
      flash[:notice] = _("Message not updated!")
    end
    
    render :action => :edit

  end
  def index
    @message_translations = MessageTranslation.find(:all)
  end
  def require_gettext_wysiwyg_mode
    redirect_to '/' unless $gettext_wysiwyg
  end
end