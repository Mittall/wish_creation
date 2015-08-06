require 'omniauth-openid'
require 'openid/store/filesystem'
 
Rails.application.config.middleware.use OmniAuth::Builder do
    #provider :developer unless Rails.env.production?
    #provider :twitter, 's6ykcNaCbCBRoifGW1foVcyvz', '6TblvmgknbcbyuwOYGSgkkERoFqx2KuaiOwMyfwJnvHbirrwtv'
    #provider :facebook, '1416252865305926', 'dfdd6086905fa30d30bda3c396ab20a0'
    #provider :linkedin, '75vh9phi7dyiy9', 'ywqeKDYeHZ2LqmkP'
		provider :twitter, 's6ykcNaCbCBRoifGW1foVcyvz', '6TblvmgknbcbyuwOYGSgkkERoFqx2KuaiOwMyfwJnvHbirrwtv'
    provider :facebook, '1416252865305926', 'dfdd6086905fa30d30bda3c396ab20a0'
    provider :linkedin, '75vh9phi7dyiy9', 'ywqeKDYeHZ2LqmkP'
    provider :open_id, :store => OpenID::Store::Filesystem.new('/tmp')
    
    provider :podio, 'mynew', 'IYGOBaYgLa8wWde5EG3QeuOwi7k2YHrmdggk2IJK1o5YPMPCUspQp6DL61Ld2XuQ'
    # Mention other providers here you want to allow user to sign in with
end

