# # CarrierWaveの設定呼び出し
# require 'carrierwave/storage/file'
# require 'carrierwave/storage/fog'
# # 画像名に日本語が使えるようにする
# CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
# CarrierWave.configure do |config|
#   # 本番環境はS3に保存
#   if Rails.env.production?
#     config.storage = :fog
#     config.fog_provider = 'fog/aws'
#     config.fog_directory = 'pf-cooklog'
#     config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/pf-cooklog'
#     config.fog_public = false
#     config.fog_credentials = {
#       provider: 'AWS',
#       # credentialsで管理する場合
#       aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
#       aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
#       region: 'ap-northeast-1'
#     }
#   else
#     config.storage :file
#   end
# end
