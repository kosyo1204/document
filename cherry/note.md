
配列には異なるデータ型を詰めることもできる
arr = [123, '123', {key: 'value'}]

存在しないインデックスを指定するとnilが帰る。
arr[100] #=> nil

<<で配列の末尾に値を追加
arr << 100
arr = [123, '123', {key: 'value'}, 100]

配列の指定の位置の要素はdelete_atで削除。存在しないキーならnilを返す。
arr.delete_at(2)
arr = [123, '123', 100]
arr.delete_at(100) #=> nil

deleteメソッドは配列内の一致する値を削除する
a = [1,2,3,4,1,2,3]
a.delete(2) 
a #=> [1,3,4,1,3]

要件を問わず共通処理はメソッドに、要件によって異なる処理はブロックに処理を委ねる。
a = [1,2,3,4,1,2,3]
a.delete_if do |n|
	n.odd?
end
a #=> [2,4,2]

ブロックはメソッドの引数として渡すことができる処理の塊。
配列に対するeachメソッドはブロッックとしてdo~endを受け取る。
numbers.each do |n|
	sum += n
end

使用頻度が高いブロックを使う配列のメソッド
- map/collect
ある配列に対してループ処理した結果を空の配列に入れる処理はmapメソッドを使える
numbers = [1,2,3,4,5]
new_numbers = numbers.map {|n| n*10}
# mapメソッドを使わない場合
# new_numbers = []
# numbers.each {|n| new_numbers << n * 10}
puts new_numbers

- select/find_all/reject
select(find_all)はtrueの値だけを返す
反対にrejectはfalseの値。
numbers = [1,2,3,4,5,6]
even_numbers = numbers.select { |n| n.even?}
non_multiples_of_three = numbers.reject { |n| n % 3 == 0 }
p non_multiples_of_three

- find/detect
最初に真となった要素
numbers = [1,2,3,4,5,6]
even_number = numbers.find { |n| n.even?}
p even_number

- sum
要素の合計を返す
numbers = [1,2,3,4,5,6]
numbers.sum #=> 21
各要素を2倍して足し算することも可能
numbers.sum{ |n| n * 2} #=> 42
初期値の設定も可能。デフォルトは0
p numbers.sum(9)
数値だけでなく文字列も連結できる
初期値（文頭の文字）を渡す必要あり
chars = ['a', 'b', 'c']
p chars.sum('')
joinでも連結できる。区切り文字の指定も可能
chars.join('-')
連結するときはto_sで数字を文字列へ変換するので混在していてもOK（joinのみ）
shuffle_chars = ['a', 2, 'c', 4]
p shuffle_chars.join('-')

単純に連結するだけならjoin、
初期値を設定したり条件を加えたい場合はsumを使うと良い。
chars = ['a', 'b', 'c']
先頭に>をつけて各要素を大文字にしたい場合
chars.sum('>') { |n| n.upcase }

&とシンボルを使えば簡潔に書ける
p ['ruby', 'java', 'python'].map { |s| s.upcase }
上記は以下へ書き換えられる
p ['ruby', 'java', 'python'].map(&:upcase)
利用条件と書けないパターン
1. ブロックパラメータが一つ
[1,2,3].map do |n|
	m = n * 4
	m.to_s
end

2. ブロックの中で呼び出すメソッドに引数がない
[1,2,3].map {|n| n.to_s(16)}

3. ブロック内でブロックパラメータに対して行う処理はメソッドを１度呼び出すだけ
[1,2,3].map {|n| n % 3 == 0}


# Range
値の範囲を示す範囲オブジェクトがある。
範囲オブジェクトは..か...で示す
違いは末尾を含めるか否か
p (1..5).include?(5)
p (1...5).include?(5) #=> false 4.99・・・までは含む
p (1...5).include?(4.9) #=> true
includeメソッドを使うときは、範囲オブジェクト()で囲まなければエラーとなる。
..や...は優先順位が低いため

## 範囲オブジェクトを使うと便利な場面

1. 配列や文字列の一部を抜き出す
a = [1,2,3,4,5]
p a[1..3]
b ='12345'
p b[1...3]

2. n以上m以下、n以上m未満を判定する
不等号よりもシンプルにかける

def liquid?(temperature)
  0 <= temperature && temperature < 100
  # 範囲オブジェクトを使うなら
  (1...100).include?(temperature)
end

p liquid?(-1) #=> false
p liquid?(0) #=> true
p liquid?(99) #=> true
p liquid?(100) #=> false

3. case文で使う
def charge(age)
  case age
  when 0..5
    0
  when 6..12
    300
  when 13..18
    600
  else
    1000
  end
end

p charge(3)
p charge(12)
p charge(16)
p charge(25)

4. 値が連続する配列を作成する
範囲オブジェクトにto_aメソッドもしくは
[*範囲オブジェクト]と書くと配列を作ることができる
p (1..5).to_a
p ('a'..'e').to_a
p ('a'...'e').to_a
p ('abc'..'abe').to_a
p [*1..5]
p [*'a'..'e']

5. 繰り返し処理を行う
範囲オブジェクトに直接eachメソッドを呼び出すこともできる
sum = 0
(1..5).each { |n| sum += n}
# sumでもいける
arr = (1..5).sum 
p arr

stepメソッドで間隔を指定することも
numbers = []
(1..10).step(2) { |n| numbers << n}
p numbers

## rgb変換プログラム


# ハッシュやシンボルを理解する
ruby 3以降ではキーワード引数として渡していたハッシュが展開されなくなった。
キーワード引数として明示するためにはハッシュの前に**をつける必要がある。
キーワード引数の場合は呼び出し時に必ず引数名をシンボルで指定する。

最後の引数はハッシュリテラルの{}を省略できる
メソッドだけでなく、配列も同様


シンボルを使えないケースを押さえておく


# クラスの作成を理解する
ハッシュは新しくキーを追加したり、内容を変更したりできるので脆くて壊れやすいプログラムになりがち
→大きなプログラムになると管理しきれなくなる。
そこで登場するのがクラス。
メリット
・内部にデータを保持でき、保持するデータを利用する独自のメソッドを持つ。
・属性と振る舞いが常にセットになるため、データとメソッドを整理しやすくなる。

・initializeはデフォルトでprivateメソッドとなっているため、外部からは呼び出せない。
・ローカル変数はメソッドやブロックが呼ばれる都度生成される。
・インスタンス変数の値をクラスの外部から読み書きする場合は、attr_accessorメソッドを使うと良い

・クラスに関連は深いが、インスタンスに含まれるデータは使わないメソッドを定義するとき
＝クラスメソッドを定義
・クラスの中には定数を定義することもできる

## selfキーワード
メソッドの内部で他のメソッドを呼び出す時に使う。
基本的にはselfはつけなくても良いが、name= メソッドの場合はselfが必須。
ローカル変数のように捉えられてしまうため。



# モジュール

## Enumerableモジュール
  selectやmapなどの便利なメソッドを利用できる。
  eachを実装しているクラスにincludeすることで利用可能。

## Comparableモジュール
  比較演算子を利用可能
  <=>を実装すれば利用可能

## Kernelモジュール
  printやp、requireなどを利用できる。
  Objectクラスがincludeしているため。

