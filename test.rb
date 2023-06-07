require "csv"

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"
memo_type = gets.to_i

#メモを新規作成する
if memo_type == 1
  puts "作成したいファイル名を拡張子を除いて入力してください"
  file_name = gets.chomp

  puts "メモしたい内容を入力してください"
  puts "Ctrl+Dを押して保存します"
  input_memo = STDIN.read
  puts "ファイルが作成されました"

  CSV.open("#{file_name}.csv", "w") do |csv|
    csv << ["#{input_memo}"]
  end

#メモを編集する(追加のみ)
elsif memo_type == 2
  puts "編集したいファイル名を拡張子を除いて入力してください"
  file_name = gets.chomp
  
  #編集したいファイルが存在する場合
  if File.exist? ("#{file_name}.csv")
    puts "メモを表示します"
    CSV.foreach("#{file_name}.csv") do |show|
      puts "------------------------"
      puts show
      puts "------------------------"
    end
    puts "追加したい内容を入力してください"
    puts "Ctrl+Dを押して保存します"
    input_memo = STDIN.read
    CSV.open("#{file_name}.csv", "a") do |csv|
      csv << ["#{input_memo}"]
    end
    puts "メモを更新しました"
  #編集したいファイルが存在しない場合
  else
    puts "入力したファイルは存在しません"
  end

#1or2が入力されなかった場合
else
  puts "※1か2を入力してください※"
end