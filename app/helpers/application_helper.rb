module ApplicationHelper
  def home_page?
    params[:controller] == "home" && params[:action] == "index"
  end

  def devise_page?
    devise_page = %w(devise/sessions devise/passwords devise/registrations)
    devise_page.map { |e| return true if params[:controller] == e }
    false
  end

  def display_time(time)
    time > 1.day.ago ? time_ago_in_words(time) : time.strftime("%b %d, %I:%m%p")
  end

  def card_label_helper(word)
    kolor = if word.note?
      "blue"
    else
      "red"
    end
  end

  def word_icon_helper(word)
    klass = if word.note?
      "file word outline"
    else
      "translate"
    end
  end

  def detect_background
    bg = if home_page?
      "default_bg"
    else
      "blue_bg"
    end
  end
end
