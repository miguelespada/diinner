# encoding: utf-8

##
# Backup Generated: my_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t my_backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:my_backup, 'Backup mongo s3 diinner') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # MongoDB [Database]
  #
  database MongoDB do |db|
    db.name               = ENV['MONGO_DATABASE']
    db.host               = ENV['MONGO_HOST']
    db.port               = ENV['MONGO_PORT']
    db.ipv6               = false
    db.additional_options = []
    db.lock               = false
    db.oplog              = false
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  # Available Regions:
  #
  #  - ap-northeast-1
  #  - ap-southeast-1
  #  - eu-west-1
  #  - us-east-1
  #  - us-west-1
  #
  store_with S3 do |s3|
    s3.access_key_id     = ENV['AMAZON_S3_ACCESS_KEY']
    s3.secret_access_key = ENV['AMAZON_S3_SECRET_ACCESS_KEY']
    s3.region            = ENV['AMAZON_S3_REGION']
    s3.bucket            = ENV['AMAZON_S3_BUCKET']
    s3.path              = ENV['AMAZON_S3_PATH']
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

end
