module IntroHelper
  def first_visit?
    if session[:visited]
      false
    else
      session[:visited] = true
    end
  end

  def first_signed_in?
    return false unless user_signed_in?
    if session[:signed_in?]
      false
    else
      session[:signed_in?] = true
    end
  end
end
