class TalksController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_user, only: [:index]
  before_action :set_meeting, only: [:new]
  before_action :set_talk, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]

  def index
    @talks = @user.talks.latest.includes(:user, :meeting).page(params[:page])
  end

  def show
    @comments = @talk.comments.includes(:user).to_a
    @comment = @talk.comments.new
  end

  def new
    @talk = @meeting.talks.new(user_id: current_user.id)
  end

  def create
    @meeting = Meeting.find(params[:talk][:meeting_id])
    @talk = @meeting.talks.new(talk_params)
    if @talk.save
      redirect_to @talk, notice: 'Talk was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @talk.update(talk_params)
      redirect_to @talk
    else
      render :edit
    end
  end

  def destroy
    @talk.destroy
    redirect_to @talk.meeting, notice: 'Talk was successfully deleted.'
  end

  def upcoming
    @talks = Talk.upcoming.page(1)
  end

  def recent
    @talks = Talk.recent.includes(:meeting, :user).page(1)
  end

  def popular
    @talks = Talk.popular.includes(:meeting, :user).page(1)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_meeting
    @meeting = if params[:meeting_id]
                 Meeting.find(params[:meeting_id])
               else
                 Meeting.next
               end
  end

  def set_talk
    @talk = Talk.includes(:tags).find(params[:id])
  end

  def talk_params
    params.require(:talk)
          .permit(:meeting_id, :title, :user_id, :description, :category,
                  :overview, :tag_list, :attachment)
  end

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post({
      key: "uploads/#{SecureRandom.uuid}/${filename}",
      success_action_status: '201',
      acl: 'public-read'
    })
  end
end
