class Link < ApplicationRecord
  validates :full_url, presence: true, on: :create
  validates :full_url, :format => URI::regexp(%w(http https www))
  before_create :generate_short_url
  
  # Assign a short url
  def generate_short_url

    # Generate 3 arrays with lowercase, upper case and nums
    lower = ('a'..'z').to_a
    upper = ('A'..'Z').to_a
    num = ('0'..'9').to_a
    letters = lower.concat(upper)
    chars = letters.concat(num)

    # Get last short_url in db 
    # If there is none, then start the short_url at 'a'
    if Link.last == nil
      last_short_url = "a"
      short_char = 0
    else

      # Grab last digit of short_url from last link to account for double digit URLs
      last_short_url = Link.last.short_url[-1]

      # Add 1 to get the next index in the array and set the new short url
      short_char = chars.find_index(last_short_url) + 1
    end
    link = Link.find_by_short_url(chars[short_char])
    if link.nil? && short_char <= 61
      self.short_url = chars[short_char]
    else
      shuffled_chars = chars.shuffle[0,2].join
      self.short_url = shuffled_chars
    end
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
