module ContestHelpers
  def show_contest_path(nth, anchor: nil)
    if anchor
      "/contest/#{nth}##{anchor}"
    else
      "/contest/#{nth}"
    end
  end
end
