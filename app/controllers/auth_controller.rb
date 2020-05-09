class AuthController < ApplicationController
  skip_before_action :require_login, only: [:create], raise: false

  # ログインtoken
  def create

    begin
      user = User.find_by(email: params[:email])
      token = ''
      status = :unauthorized
      if user && user.authenticate(params[:password])
        token = Session.create(user)
        position = user.position
        id = user.id
        render json: { token: token, position: position, id: id }
      else
        render json: {message: "ユーザーが見つかりませんでした。"}
      end
    rescue
      render json: { message: "token作成失敗しました。"}
    end

  end
end