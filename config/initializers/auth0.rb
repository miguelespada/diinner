Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider(
        :auth0,
        'ehMqgad1vB3TkYsH7qYXkVEqiBQgdrl5',
        '4zrefWQz1QFtogYRMtGLONOEc2_VtQRAyEkYS0cb6iok0cdnK4IcudFTbwo-3PEB',
        'rodcrespo.eu.auth0.com',
        callback_path: "/auth/auth0/callback"
    )
  else Rails.env.production?
    provider(
      :auth0,
       ENV['AUTH0_CLIENT_ID'],
       ENV['AUTH0_CLIENT_SECRET'],
       ENV['AUTH0_DOMAIN'],
      callback_path: "/auth/auth0/callback"
    )
  end
end