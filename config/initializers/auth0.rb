Rails.application.config.middleware.use OmniAuth::Builder do
    provider(
        :auth0,
        'BBLhUOEcSMo60RljToZKPWzNClPnAOPl',
        '4zrefWQz1QFtogYRMtGLONOEc2_VtQRAyEkYS0cb6iok0cdnK4IcudFTbwo-3PEB',
        'app35743745.eu.auth0.com',
        callback_path: "/auth/auth0/callback"
    )
end