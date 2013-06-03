User.create(
  confirmation_sent_at: Time.now, confirmed_at: Time.now,
  current_sign_in_at: Time.now, current_sign_in_ip: '127.0.0.1', display_name: 'Pepper Mind',
  email: 'kontakt.peppermind@gmail.com',encrypted_password: SecureRandom.hex, last_sign_in_at: Time.now,
  last_sign_in_ip: '127.0.0.1', level: 'rookie', points: 0, sign_in_count: 1
)
