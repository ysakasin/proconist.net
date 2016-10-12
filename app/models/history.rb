class History < ApplicationRecord
  def type
    case label
    when 0
      :product
    when 1
      :entry
    when 2
      :notice
    end
  end
end
