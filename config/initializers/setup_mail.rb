ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com'
  port:                 'port',
  domain:               'wyshme.com',
  user_name:            'user_name',
  password:             'password',
  authentication:       'plain',
  enable_starttls_auto: true,
}
