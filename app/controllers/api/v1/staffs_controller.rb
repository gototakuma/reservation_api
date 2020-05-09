module Api
  module V1
    class StaffsController < ApplicationController

      # スタッフ名前取得
      def index
        staffs = Staff.pluck("name")
        render :json => staffs
      end

      # 全スタッフデータ取得
      def staffs_data
        staffs = Staff.all
        render json: staffs
      end

      # スタッフ作成
      def create

        begin

          message = params_check

          render json: {message: message} and return if message.present?

          staff = Staff.new(
            name: params[:name],
            age: params[:age],
            description: params[:description],
            sex: params[:sex]
          )
          staff.save
          render json: {status: "success"}

        rescue => e
          render json: {message: "システムエラーが発生しました。"}
          logger.error "Error: #{e}"
        end

      end

      # # スタッフ更新
      def update

        begin

          message = params_check

          render json: {message: message} and return if message.present?

          staff = Staff.find(params[:id])
          staff.update!(
            name: params[:name],
            age: params[:age],
            sex: params[:sex],
            description: params[:description]
            )

          render json: {
            status: "success",
            staff: {
              name: staff.name,
              age: staff.age,
              sex: staff.sex,
              description: staff.description
            }}

        rescue => e
          render json: {messge: "システムエラーが発生しました。"}
          logger.error "Error: #{e}"
        end

      end

      def delete

        begin
          
          staff = Staff.find(params[:id])
          staff.destroy!

          render json: {status: "success"}
        rescue => e
          render json: {message: "システムエラーが発生しました。"}
          logger.error "Error: #{e}"
        end

      end

      private

      def params_check
        message = []
        message << "名前が入力されていません。" if params[:name].blank?
        message << "年齢が入力されていません。" if params[:age].blank?
        message << "説明が入力されていません。" if params[:description].blank?
        message << "性別が入力されていません。" if params[:sex].blank?
      end

    end
  end
end