# encoding: utf-8
class SummaryInfosController < ApplicationController
  def index
#    @summary_infos = SummaryInfo.all

#   paginate produces sql-statement automatically

# 事例
#    @summary_infos = SummaryInfo.where("restaurant_name like '%おらが%'"
#    ).paginate(:page => params[:page],
#     :order => 'restaurant_name, lunch_name, created_at desc',
#     :per_page => 3)
#
#   SELECT "summary_infos".* FROM "summary_infos"
#     WHERE (restaurant_name like '%おらが%')
#     ORDER BY restaurant_name, lunch_name, created_at desc 
#     LIMIT 3 OFFSET 0

# 以下の変数は、抽出条件・並び順・表示件数／頁です。
# 外部からパラメータ収集して、上書き編集して下さい。
    stmt_where = ""
    stmt_order = 'restaurant_name, lunch_name, created_at desc'
    lines_per_page = 3

    @summary_infos = SummaryInfo.where(stmt_where).paginate(
     :page     => params[:page],
     :order    => stmt_order,
     :per_page => lines_per_page)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @summary_infos }
    end
  end
end
