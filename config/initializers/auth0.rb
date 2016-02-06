Rails.application.config.middleware.use OmniAuth::Builder do
    provider(
        :auth0,
        'BBLhUOEcSMo60RljToZKPWzNClPnAOPl',
        '5qeGPCT17bqUzqANM-13_dHP26nEyw0XrVwSutrO6ZS_sbszJIgDA_nit5Xx6v2u',
        'app35743745.eu.auth0.com',
        callback_path: "/auth/auth0/callback"
    )
end