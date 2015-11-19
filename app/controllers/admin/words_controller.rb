class Admin::WordsController < Admin::BaseController
  before_action :set_word, only: [:edit, :update, :destroy, :show]
  
  def index
    @words = Word.page(params[:page])
  end

  def show
  end

  def new
  end

  def create
    @word = current_user.words.build(word_params)

    if @word.save
      flash[:success] = "Word created!"
      redirect_to admin_words_path
    else
      flash[:error] = "Create word failed!"
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update(word_params)
      flash[:success] = "Word updated!"
      redirect_to admin_words_path
    else
      flash[:error] = "Update word failed!"
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = "Word deleted!"
    else
      flash[:error] = "Delete word failed!"
    end
    redirect_to admin_words_path
  end

  private

  def set_word
    @word = Word.find(params[:id])
  end

  def word_params
    params.require(:word).permit(:title, :content)
  end
end
