class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
	before_filter :setup_negative_captcha, :only => [:new, :create]
  
	def index
	  @users = User.find(:all, :conditions => ['first_name LIKE ?', "%#{params[:search]}%"])
	  respond_to do |format|
	  	format.html # index.html.erb
	  	format.js   # index.js.erb
	  	format.xml  { render :xml => @patterns }
	  end
	end
	
  def new
    @user = User.new
  end
  
  def create
		if @captcha.valid?
			@user = User.new(@captcha.values) #Decrypted params
		end
	
    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
		if @captcha.valid? && @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
		else
			flash[:notice] = @captcha.error
			render :action => 'new'
		end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
		if params[:id]
			@user = User.find(params[:id])
		else
			@user = @current_user # makes our views "cleaner" and more consistent
		end
		@user.attributes = params[:user]
		@user.save
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
	
	def manage
		@user = User.find(params[:id])
	end
	
	private
		def setup_negative_captcha
			@captcha = NegativeCaptcha.new(
				#A secret key entered in environment.rb.  'rake secret' will give you a good one.
				:secret => ::NEGATIVE_CAPTCHA_SECRET, 
				:spinner => request.remote_ip,
				#Whatever fields are in your form  
				:fields => [:first_name, :last_name, :email, :login, :password, :password_confirmation],
				:params => params)
		end
end
