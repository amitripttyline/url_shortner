class Url < ApplicationRecord
  # Track the number of times a URL has been clicked
  attribute :click_count, :integer, default: 0
  # Allow dynamic max_click per URL (no default, must be set from form)
  attribute :max_click, :integer

  before_validation :reset_click_count, on: :create

  def reset_click_count
    self.click_count = 0 if click_count.nil?
  end
  validates :original_url, presence: true
  validate :original_url_is_valid_route
  validates :short_url, uniqueness: true
  validates :token, presence: true

  before_validation :generate_short_url, on: :create
  before_validation :generate_token, on: :create

  def can_be_clicked?
    return false if max_click.nil?
    click_count <= max_click
  end

  # Sets the click_count to max_click
  def maximize_click_count!
    return if max_click.nil?
    update!(click_count: max_click)
  end

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
