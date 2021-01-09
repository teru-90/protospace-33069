class PrototypesController < ApplicationController
  # before_action :authenticate_user!     #authenticate_user! 処理が呼ばれた段階で、ユーザーがログインしていなければ、そのユーザーをログイン画面に遷移させるメソッド
    before_action :authenticate_user!, except: [:index, :show ]
    before_action :move_to_signe_in_path, only:[:edit, :destroy]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototypes = Prototype.create(prototype_params)
    
    if @prototypes.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments 
  #  @comments = Comment.includes(:prototype)この記述でもshowのビューにコメント表示できたが、２１行目で引っ張っているので、それを使う。
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to  prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  private
    # ストロングパラメーターをセット
  def prototype_params
  	#2重ハッシ構造params .パラメーターからどの情報を取得するか選択require（：モデル名）．取得したいキーを指定するpermit(:キー名, :キー名） :キー名だけで、キーと値のセットで取得できる。 .ハッシュを結合させる時に使うmerge()
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id)
  end

    #ログインしていない人はトップページ
  def move_to_signe_in_path  
    unless  current_user.id == Prototype.find(params[:id]).user.id
    # unless  current_user.id == @prototype.user.id
      redirect_to  root_path
    end
  end
end
