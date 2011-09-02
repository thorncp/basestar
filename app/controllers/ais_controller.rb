class AisController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :public, :download]
  before_filter :get_ai, :only => [:edit, :update, :destroy]
  before_filter :get_public_ai, :only => [:show, :download]

  def index
    if user_signed_in?
      @ais = current_user.ais
    else
      redirect_to :action => "public"
    end
  end

  def public
    @ais = Ai.public
    render "index"
  end

  def show
  end

  def download
    send_data @ai.source, :filename => @ai.file_name
  end

  def new
    @ai = Ai.new
  end

  def create
    @ai = current_user.ais.build(params[:ai])

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

  # If the user is signed in, redirects to ais_path. Else, redirects
  # to public_ais_path.
  def redirect_to_base(options = {})
    path = user_signed_in? ? ais_path : public_ais_path
    redirect_to path, options
  end

  def get_ai(options = {})
    @ai = Ai.find(params[:id])
    unless @ai.user == current_user || (options[:public] && @ai.public?)
      redirect_to_base :alert => "You did it wrong"
    end
  end

  def get_public_ai
    get_ai :public => true
  end
end
