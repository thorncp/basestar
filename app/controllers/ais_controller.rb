class AisController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :public]
  before_filter :get_ai, :only => [:edit, :update, :destroy]

  def index
    @ais = current_user.ais
  end

  def public
    @ais = Ai.where(:public => true)
    render "index"
  end

  def show
    get_ai(true)
  end

  def new
    @ai = Ai.new
  end

  def create
    @ai = current_user.ais.build(params[:ai])

    @ai.public = params[:ai][:public] == "1"

    if params[:ai][:source]
      @ai.source = File.read(params[:ai][:source].tempfile) 
      @ai.file_name = params[:ai][:source].original_filename
    end

    if @ai.save
      redirect_to @ai, :notice => "Successfully created ai."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    @ai.attributes = params[:ai]

    @ai.public = params[:ai][:public] == "1"

    if params[:ai][:source]
      @ai.source = File.read(params[:ai][:source].tempfile) 
      @ai.file_name = params[:ai][:source].original_filename
    end

    if @ai.save
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

  def get_ai(pub = false)
    @ai = Ai.find(params[:id])

    unless @ai.user == current_user || pub
      redirect_to ais_path, :alert => "You did it wrong"
    end
  end
end
