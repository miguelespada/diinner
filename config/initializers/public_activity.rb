PublicActivity.config.orm :mongoid 

PublicActivity::Common.class_eval do
   def remove_activities
    PublicActivity::Activity.or({recipient: id}, {owner: id}, {trackable: id}).delete_all
  end
end