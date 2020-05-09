module Api
  module V1
    class ReservationsController < ApplicationController
      def create
        
        begin
          message = []
          message << "担当美容師が選択されていません。" if params[:staff].blank?
          message << "日付が選択されていません。" if params[:date].blank? || params[:time].blank?
          message << "コースが選択れせていません。" if params[:orders].blank?

          render json: {message: message} and return if message.present?

        # 時間結合
          date = params[:date].to_s + "T" + params[:time]
          reservation_date = date.to_datetime

          # コース複数配列
          cources = params[:orders].map{ |order| order[:cource] }.join(',')

          # 時間・料金の合計
          time = 0
          price = 0
          params[:orders].each do |order|
            time += order[:time]
            price += order[:price]
          end

          # 予約データ作成
          reservation = Reservation.new(
            staff: params[:staff],
            reservation_date: reservation_date,
            cource: cources,
            time: time,
            price: price,
            user_id: params[:user_id]
          )
          reservation.save!

          render json: {status: "success"}
        rescue => e
          render json: {message: "システムエラーが発生しました。"}
          logger.error "Error: #{e}"
        end

      end

      def show

        # 今日の予約情報
        reservation_today_data =  Reservation.find_by(user_id: params[:user_id], reservation_date: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)

        render :json => { reservationNow:{ message: "今日の予約はありません。" }} and return if reservation_today_data.nil?

        reservation_today = {
          staff: reservation_today_data.staff,
          reservation_date: reservation_today_data.reservation_date.strftime("%H:%M"),
          cource: reservation_today_data.cource,
          time: reservation_today_data.time,
          price: reservation_today_data.price
        }

        render :json => {reservationNow: reservation_today}
      end

      #　ユーザー予約検索
      def search
        req_date = params[:date]
        date = Reservation.find_by(reservation_date: req_date.to_time.beginning_of_day..req_date.to_time.end_of_day, user_id: params[:user_id])
        
        render :json => {reservation_his: {message: "予約が見つかりませんでした。"}} and return if date.nil?

        date = {
          staff: date.staff,
          cource: date.cource,
          reservation_date: date.reservation_date.strftime("%H:%M"),
          time: date.time,
          price: date.price
        }
        render :json => {reservation_his: date}
      end

      # 管理者全予約取得
      def all_data
        reservations = Reservation.all
        res_data = []
        time = 0

        reservations.each do |reservation|
          end_time = (reservation.reservation_date.to_datetime + Rational(reservation.time, 24*60)).strftime("%Y-%m-%d %H:%M")
          user_name = User.find_by(id: reservation.user_id).name

          res_data << data = {
            user_name: user_name,
            staff: reservation.staff,
            reservation_start: reservation.reservation_date.strftime("%Y-%m-%d %H:%M"),
            reservation_end: end_time,
            time: reservation.time,
            price: reservation.price,
            cource: reservation.cource,
          }
        end

        render :json => {reservations: res_data}
      end

    end
  end
end
