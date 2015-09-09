PublicActivity.config.orm :mongoid 

PublicActivity::Common.class_eval do
   def remove_activities
    PublicActivity::Activity.where(recipient: id).delete_all
    PublicActivity::Activity.where(owner: id).delete_all
    PublicActivity::Activity.where(trackable: id).delete_all
  end
end
