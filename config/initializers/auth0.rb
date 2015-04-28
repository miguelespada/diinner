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
      'BBLhUOEcSMo60RljToZKPWzNClPnAOPl',
      '5qeGPCT17bqUzqANM-13_dHP26nEyw0XrVwSutrO6ZS_sbszJIgDA_nit5Xx6v2u',
      'app35743745.eu.auth0.com',
      callback_path: "/auth/auth0/callback"
    )
  end
end