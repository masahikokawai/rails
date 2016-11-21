class MicropostsController < ApplicationController
#  before_action :signed_in_user
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      # マイクロポストの投稿が失敗すると、Homeページは@feed_itemsインスタンス変数を期待しているため、現状では壊れる
      # このことはテストスイートを実行して確認できる
      # 最も簡単な解決方法は、リスト10.42のように空の配列を渡す
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end

