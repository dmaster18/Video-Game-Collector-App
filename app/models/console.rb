class Console < ActiveRecord::Base
  belongs_to :user
  has_many :games

  def company_and_name
    if self.company != nil && self.company != "" && self.name != nil && self.name != ""
      "#{self.company.capitalize} #{self.name.split(" ").map(&:capitalize).join(" ")}"
    else
      nil
    end
  end

end
