class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  before_action :user_admin,{only: [:index]}
  def index
    @users = User.all.page(params[:page]).per(10)
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def new
    @user = User.new
  end
  
  def create
   @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "新規登録できました"
      redirect_to("/") 
    else
      flash[:alert] = '新規登録できませんでした'
      render :new
    end
  end
  

  def login
  end

  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def login_form
  end
  
  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/")
    else
      flash[:notice] = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/home/top")
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: 'ユーザーを削除しました'
  end
  
  private
    def ensure_correct_user
      if( @current_user.id != params[:id].to_i ) && ( @current_user.admin == false)
        flash[:notice] = "権限がありません"
        redirect_to("/")
      end
    end
    
    def user_admin
       if  @current_user.admin == false
          flash[:notice] = "権限がない"
           redirect_to ("/")
       end
    end
  

end
