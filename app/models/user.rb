class User < ActiveRecord::Base

  validates :email, :session_token, :password_digest, presence: true
  validates_uniqueness_of :email

  after_initialize :ensure_session_token


  def self.find_by_credentials(email, password)
    found = User.find_by(email: email)
    if found
      return found if found.is_password?(password)
      nil
    end
    nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
  end


  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end # this will still get called regardlessly, because this is overwriting
  #active record's default methods


  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end



end
