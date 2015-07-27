class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  crop_uploaded :avatar  ## Add this
end
