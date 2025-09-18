class Url < ApplicationRecord
  validates :original_url, presence: true
  validate :original_url_is_valid_route
  validates :short_url, uniqueness: true
  validates :token, presence: true

  before_validation :generate_short_url, on: :create
  before_validation :generate_token, on: :create

  private

  def generate_short_url
    self.short_url ||= loop do
      random_url = SecureRandom.urlsafe_base64(6)
      break random_url unless Url.exists?(short_url: random_url)
    end
  end

  def generate_token
    self.token ||= SecureRandom.hex(10)
  end

  def original_url_is_valid_route
    return if original_url.blank?
    # Extract path from original_url
    uri = URI.parse(original_url) rescue nil
    path = uri&.path || original_url
    # Check if path matches any route
    valid = Rails.application.routes.recognize_path(path) rescue nil
    # Only allow if the route is not the catch-all redirect
    if valid.nil? || (valid[:controller] == 'urls' && valid[:action] == 'redirect')
      errors.add(:original_url, 'is not a valid route')
    end
  end
end
