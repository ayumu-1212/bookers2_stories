class RelationshipsController < ApplicationController
  def create
    Relationship.find_or_create_by(follow_id: params[:follow_id], follower_id: current_user.id)
    redirect_back(fallback_location: users_path)
  end
  
  def destroy
    relationship = Relationship.find_by(follow_id: params[:follow_id], follower_id: current_user.id)
    relationship.destroy
    redirect_back(fallback_location: users_path)
  end
end
