class AisController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_ai, :only => [:show, :edit, :update, :destroy]

  def index
    @ais = current_user.ais
  end

  def show
  end

  def new
    @ai = Ai.new
  end

  def create
    @ai = current_user.ais.build(params[:ai])

    @ai.source = File.read(params[:ai][:source].tempfile)

    if @ai.save
      redirect_to @ai, :notice => "Successfully created ai."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @ai.update_attributes(params[:ai])
      redirect_to @ai, :notice  => "Successfully updated ai."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @ai.destroy
    redirect_to ais_url, :notice => "Successfully destroyed ai."
  end

  private

  def get_ai
    @ai = Ai.find(params[:id])

    if @ai.user != current_user
      redirect_to ais_path, :alert => "You did it wrong"
    end
  end
end
