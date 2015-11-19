class TranslatesController < BaseController
  before_action :set_api, only: [:translate]

  def translate
    @translated = @api.translate_langs(params[:translate_query])
    
    if Word.translate.find_by(title: params[:translate_query]).blank?
      @word = current_user.words.translate.create(translate_word_params)
    end

    respond_to do |format|
      format.js
    end
  end

  def history
    @words = current_user.words.translate.newest.page(params[:page])
  end

  private

  def set_api
    @api = Yandex::API.new
  end

  def translate_word_params
    {
      title: params[:translate_query],
      content: @translated["text"].first
    }
  end

end
