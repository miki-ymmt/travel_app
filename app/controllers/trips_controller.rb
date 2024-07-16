class TripsController < ApplicationController
  before_action :require_login
  before_action :set_trip, only: %i[show edit update destroy todos add_todo update_todo destroy_todo]


  def index
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params) # フォームから送信されたパラメータを元に旅行を作成
    @trip.user = current_user # 旅行を作成したユーザーを設定
    if @trip.save # 旅行の保存に成功した場合
      add_default_todos(@trip)  # default_todos_for メソッドを使って旅行先に応じたデフォルトのToDoを追加
      redirect_to @trip, notice: "旅行を作成しました"
    else
      flash.now[:alert] = "旅行の作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @new_todo = Todo.new # 新しいToDoを作成するためのインスタンスを作成
    @todos = @trip.todos.order(:created_at) # 旅行に紐づくToDoを取得
    @default_todo = default_todos_for(@trip.destination) # 旅行先に応じたデフォルトのToDoを取得
  end

  def todos
    @todos = @trip.todos # 旅行に紐づくToDoを取得
    @new_todo = Todo.new # 新しいToDoを作成するためのインスタンスを作成
  end

  def edit; end

  def update
    if @trip.update(trip_params)  # 旅行情報を更新
      @trip.todos.destroy_all  # 旅行に紐づくToDoを全て削除
      add_default_todos(@trip)  # default_todos_for メソッドを使って旅行先に応じたデフォルトのToDoを追加
      redirect_to @trip, notice: "旅行情報が更新されました"
    else
      render :edit
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path, notice: "旅行を削除しました"
  end

  def add_todo # 特定の旅行に対して新しいToDoを追加するアクション
    @todo = @trip.todos.build(todo_params) # 旅行に紐づくToDoを作成
    if @todo.save
      render turbo_stream: turbo_stream.append("todo-list", partial: "trips/todo", locals: { todo: @todo }) # Turbo Stream を使ってToDoを追加
    else
      render turbo_stream: turbo_stream.replace("todo_form", partial: "trips/todo_form", locals: { todo: @todo }), status: :unprocessable_entity # エラーが発生した場合はエラーメッセージを表示
    end
  end

  def update_todo
    @trip = Trip.find(params[:id])  # 特定の旅行を取得
    @todo = @trip.todos.find(params[:todo_id])  # 特定のToDoを取得

    if @todo.update(todo_params) # ToDoを更新
      render turbo_stream: turbo_stream.replace("todo-#{@todo.id}", partial: "trips/todo", locals: { todo: @todo })  # Turbo Stream を使ってToDoを更新
    else
      render turbo_stream: turbo_stream.replace("todo-form#{@todo.id}", partial: "trips/todo_form", locals: { todo: @todo }), status: :unprocessable_entity # エラーが発生した場合はエラーメッセージを表示
    end
  end

  def destroy_todo
    @trip = Trip.find(params[:id])  # 特定の旅行を取得
    @todo = @trip.todos.find(params[:todo_id])  # 特定のToDoを取得
    @todo.destroy # ToDoを削除
    render turbo_stream: turbo_stream.remove("todo-#{@todo.id}") # Turbo Stream を使ってToDoを削除
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:destination, :departure_date, :return_date, :notes)
  end

  def todo_params
    params.require(:todo).permit(:content, :done)
  end

  def add_default_todos(trip)
    default_todos = default_todos_for(trip.destination)
    default_todos.each do |todo_content|
      trip.todos.create(content: todo_content)
    end
  end

  def default_todos_for(destination)
    common_items = [
      "パスポートを用意(期限まで半年以上であること)",
      "航空券の予約",
      "ホテルの予約",
      "常備薬の用意",
      "旅行保険の加入",
      "SIMカード購入 or WIFIレンタルの予約",
      "緊急連絡先の確認",
      "スリッパの用意(飛行機内＆ホテル用)",
      "日本食の用意(恋しくなった時用)",
      "飛行機で便利なものの用意（アイマスク、耳栓、ネックピロー）",
      "スマートフォンの充電器の用意",
      "折り畳み傘の用意",
      "エコバッグ(有料化されている国が多い)",
      "パジャマの用意",
      "飲料水の用意(水の硬度が合わない場合に備える)",
      "現地の天気予報の確認",
    ]

    case destination
    when "アメリカ(ハワイを含む)"
      common_items + [
        "ESTAの申請",
        "帽子の用意",
        "サングラスの用意",
        "日焼け止めの用意",
        "カメラの用意",
        "ドルの用意（クレジットカードも含む）",
        "変換プラグの用意（タイプA）"
      ]
    when "オーストラリア"
      common_items + [
        "ETAビザの申請",
        "帽子の用意",
        "サングラスの用意",
        "日焼け止めの用意",
        "カメラの用意",
        "オーストラリアドルの用意（クレジットカードも含む）",
        "変換プラグの用意（タイプO）"
      ]
    when "タイ"
      common_items + [
        "虫除けスプレーの用意",
        "日焼け止めの用意",
        "薄手の服の用意",
        "サングラスの用意",
        "帽子の用意",
        "カメラの用意",
        "タイバーツの用意（クレジットカードも含む）",
        "変換プラグの用意（タイプA, B, C, O）"
      ]
    when "イタリア"
      common_items + [
        "変換プラグの用意（タイプC）",
        "薄手の服の用意",
        "歩きやすい靴の用意",
        "カメラの用意",
        "ユーロの用意（クレジットカードも含む）"
      ]
    when "イギリス"
      common_items + [
        "変換プラグの用意（タイプG）",
        "折りたたみ傘の用意",
        "暖かい服の用意",
        "カメラの用意",
        "ポンドの用意（クレジットカードも含む）"
      ]
    when "フランス"
      common_items + [
        "変換プラグの用意（タイプC）",
        "カメラの用意",
        "薄手の服の用意",
        "歩きやすい靴の用意",
        "ユーロの用意（クレジットカードも含む）"
      ]
    when "韓国"
      common_items + [
        "変換プラグの用意（タイプC,SE）",
        "カメラの用意",
        "韓国ウォンの用意（クレジットカードも含む）"
      ]
    when "中国"
      common_items + [
        "中国ビザの申請",
        "変換プラグの用意（タイプA, C, I）",
        "カメラの用意",
        "人民元の用意（クレジットカードも含む）"
      ]
    when "カナダ"
      common_items + [
        "eTAビザの申請",
        "帽子の用意",
        "サングラスの用意",
        "日焼け止めの用意",
        "カメラの用意",
        "カナダドルの用意（クレジットカードも含む）",
        "変換プラグの用意（タイプA, B）"
      ]
    when "スペイン"
      common_items + [
        "変換プラグの用意（タイプC, F）",
        "薄手の服の用意",
        "歩きやすい靴の用意",
        "カメラの用意",
        "ユーロの用意（クレジットカードも含む）"
      ]
    when "ドイツ"
      common_items + [
        "変換プラグの用意（タイプC, F）",
        "暖かい服の用意",
        "歩きやすい靴の用意",
        "カメラの用意",
        "ユーロの用意（クレジットカードも含む）"
      ]
    when "シンガポール"
      common_items + [
        "薄手の服の用意",
        "虫除けスプレーの用意",
        "日焼け止めの用意",
        "カメラの用意",
        "シンガポールドルの用意（クレジットカードも含む）",
        "変換プラグの用意（タイプG）"
      ]
    when "マレーシア"
      common_items + [
        "薄手の服の用意",
        "虫除けスプレーの用意",
        "日焼け止めの用意",
        "カメラの用意",
        "マレーシアリンギットの用意（クレジットカードも含む）",
        "変換プラグの用意（タイプG）"
      ]
    else
      common_items
    end
  end
end
