class WordsController < BaseController
  before_action :set_word, only: [:edit, :update, :destroy]

  def index
    @words = current_user.words.note.newest.page(params[:page])
  end

  def search
    @words = current_user.words.search(params[:title]).page(params[:page])

    if @words.blank?
      flash[:error] = "Sorry, I don't have any words match #{params[:title]}"
      redirect_to words_path
    else
      render :index
    end
  end

  def create
    @word = current_user.words.note.build(word_params)

    if @word.save
      flash[:success] = "Word created!"

      respond_to do |format|
        format.js
      end
    else
      flash[:error] = "Create word failed!"
      redirect_to words_path
    end
  end

  def edit
  end

  def update
    if @word.update(word_params)
      flash[:success] = "Word updated!"
      respond_to do |format|
        format.json { render json: @word }
        format.html
      end
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = "Word deleted!"
    else
      flash[:error] = "Delete word failed!"
    end
    redirect_to words_path
  end

  private

  def word_params
    params.require(:word).permit(:title, :content)
  end

  def set_word
    @word = Word.find(params[:id])
  end
end
