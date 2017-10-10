class Link < ApplicationRecord
  validates :full_url, presence: true, on: :create
  validates :full_url, :format => URI::regexp(%w(http https www))
  before_create :generate_short_url
  
  # Assign a short url
  def generate_short_url
    lower = ('a'..'z').to_a
    upper = ('A'..'Z').to_a
    num = (1..9).to_a
    letters = lower.concat(upper)
    chars = letters.concat(num)
    self.short_url = chars.shuffle[0,1].join
  end

  def find_duplicate
    Link.find_by_sanitized_url(self.sanitized_url)
  end
  
  def sanitize
    self.full_url.strip!

    # Remove http://, https://, www and any trailing /
    self.sanitized_url = self.full_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    self.sanitized_url.slice!(-1) if self.sanitized_url.last == "/"
    self.sanitized_url = "http://#{self.sanitized_url}"
  end
end
