# coding:utf-8

class SignupController < ApplicationController

  def signup
  end
  
  def signedup
    # パラメータからnameを取り出す
    name = params[:name]
    password = params[:password]
    session[:username] = name
     if !(name.nil?) then      
      # 既に登録されているか調べる
      currentUser = User.where(:name => name).first
      if currentUser.nil? then
        # 登録が無ければ、ユーザ登録画面へ
        puts '* not found *' + currentUser.class.name
        render :action => 'registerNewUser'
      elsif password != currentUser.password then
        puts '* not found *' + currentUser.class.name
        #redirect_to :action => 'signup'    # 修正中　 {:alert => 'パスワードがまちがっています。'}
        #redirect_to :action => 'signup', :notice => 'password error
        render :text => 'パスワードがまちがっています。', :status => 500
      else
        # 登録があれば、ユーザオブジェクトをセッションに保管して、検索条件画面へ
        puts '* found *' + currentUser.class.name
        session[:currentUser] = currentUser
        redirect_to :controller => 'summary_lists', :action => 'index' 
      end
    end
  end
  
  def registerNewUser
    
  end
  
  def newUserRegistered
    @message = ''
    
    name      = params[:username]
    password1 = params[:pass1]
    password2 = params[:pass2]
    email     = params[:email]
    
    # 未入力の場合にエラーとするようにする
    
    if password1 != password2 then
      @message = 'Error! password unmatch!'      
      render :action => 'registerNewUser'
      return
    end
    if email.nil? then
      @message = 'Error! e-mail address is empty!'      
      render :action => 'registerNewUser'
      return
    end
    
    # 同じユーザIDが登録されていないかどうかチェック
    currentUser = User.where(:name => name).first
    if !currentUser.nil? then
      @message = '指定されたユーザIDは既に登録されています。'      
      render :action => 'registerNewUser'
      return
    end

    currentUser 			= User.new()
    currentUser.name 		= name
    currentUser.email 		= email
    currentUser.password 	= password1
    session[:currentUser] 	= currentUser
    currentUser.save()
    
    redirect_to :controller => 'summary_lists', :action => 'index'   
  end
end
