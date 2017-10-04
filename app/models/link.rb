class Link < ApplicationRecord
  validates :long_url, :format => URI::regexp(%w(http https))

  def generate_short_url
    self.short_url = SecureRandom.urlsafe_base64(6)
    self.save!
  end

end
