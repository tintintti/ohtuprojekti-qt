class ReputationPostTopicsController < ApplicationController
  before_action :set_reputation_post_topic, only: [:show, :edit, :update, :destroy]

  # GET /reputation_post_topics
  # GET /reputation_post_topics.json
  def index
    @reputation_post_topics = ReputationPostTopic.all
  end

  # GET /reputation_post_topics/1
  # GET /reputation_post_topics/1.json
  def show
  end

  # GET /reputation_post_topics/new
  def new
    @reputation_post_topic = ReputationPostTopic.new
  end

  # GET /reputation_post_topics/1/edit
  def edit
  end

  # POST /reputation_post_topics
  # POST /reputation_post_topics.json
  def create
    @reputation_post_topic = ReputationPostTopic.new(reputation_post_topic_params)

    respond_to do |format|
      if @reputation_post_topic.save
        format.html { redirect_to @reputation_post_topic, notice: 'Reputation post topic was successfully created.' }
        format.json { render :show, status: :created, location: @reputation_post_topic }
      else
        format.html { render :new }
        format.json { render json: @reputation_post_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reputation_post_topics/1
  # PATCH/PUT /reputation_post_topics/1.json
  def update
    respond_to do |format|
      if @reputation_post_topic.update(reputation_post_topic_params)
        format.html { redirect_to @reputation_post_topic, notice: 'Reputation post topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @reputation_post_topic }
      else
        format.html { render :edit }
        format.json { render json: @reputation_post_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reputation_post_topics/1
  # DELETE /reputation_post_topics/1.json
  def destroy
    @reputation_post_topic.destroy
    respond_to do |format|
      format.html { redirect_to reputation_post_topics_url, notice: 'Reputation post topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reputation_post_topic
      @reputation_post_topic = ReputationPostTopic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reputation_post_topic_params
      params.require(:reputation_post_topic).permit(:tid, :reputation, :postcount)
    end
end
