module Api
  module V1
    class UsersController < ApplicationController

      # ユーザー管理
      def index
        users = Pundit.policy_scope(@session, User)
        render json: users
      end

      #管理者ユーザー詳細検索
      def show
        user = User.find_by(id: params[:user_id])
        reservations = Reservation.where(user_id: user.id)
        res = []
        reservations.each do |reservation|
          res << data = {
            staff: reservation.staff,
            reservation_date: reservation.reservation_date.strftime("%Y/%m/%d %H:%M"),
            cource: reservation.cource,
            time: reservation.time,
            price: reservation.price,
            user_id: reservation.user_id,
          }
        end

        res << data = {staff: "予約がありません。"} if res.blank?

        render :json => {user: user, reservation: res}
      end

      # ユーザー作成
      def create
        res = params[:user]

        user = User.new(
          name: res["name"],
          email: res["email"],
          password: res["password"],
          age: res["age"],
          sex: res["sex"]
        )

        if user.save
          render :json => {
            user: {
              name: user.name,
              email: user.email,
              age: user.age,
              sex: user.sex
          }
        }
        else
          render :json => user.erros
        end

      end

      def update

        begin

          user = User.find(params[:id])

          name = params[:name].present? ? params[:name] : user.name
          email = params[:email].present? ? params[:email] : user.email
          age = params[:age].present? ? params[:age] : user.age
          sex = params[:sex].present? ? params[:sex] : user.sex
          password = user.password_digest

          if params[:newPassword].present? || params[:oldPassword].present?
            debugger
            if !user.authenticate(params[:oldPassword])
              render json: {message: "古いパスワードが違います。確認お願いします。"} and return
            elsif user.authenticate(params[:oldPassword]) && params[:newPassword].present?
              password = params[:newPassword]
            else
              render json: { message: "新しいパスワードを入力してください。" } and return
            end
          end

          user.update!(
            name: name,
            email: email,
            age: age,
            sex: sex,
            password: password
          )

          render json: {status: "success"}

        rescue => e
          render json: {message: "システムエラーが発生しました。"}
          logger.error "Error: #{e}"
        end

      end


    end
  end
end