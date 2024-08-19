module TripHelper
  def image_url_for_trip(trip)
    case trip.destination
    when "ロサンゼルス"
      asset_path("los_angeles.png")
    when "ニューヨーク"
      asset_path("new_york.png")
    when "ハワイ"
      asset_path("hawaii.png")
    when "パリ"
      asset_path("paris.png")
    when "ロンドン"
      asset_path("london.png")
    when "マドリード"
      asset_path("madrid.png")
    when "シドニー"
      asset_path("sydney.png")
    when "バンコク"
      asset_path("bangkok.png")
    when "シンガポール"
      asset_path("singapore.png")
    when "上海"
      asset_path("shanghai.png")
    when "ソウル"
      asset_path("seoul.png")
    when "ミュンヘン"
      asset_path("munich.png")
    when "クアラルンプール"
      asset_path("kuala.png")
    when "ローマ"
      asset_path("rome.png")
    when "台北"
      asset_path("taipei.png")
    end
  end
end