#
# Makefileの基本的な事を記述しましたので全てのコメントに目を通して欲しいです m(_ _)m また勉強会した方が良いですかねぇ。。
#
# これはシンプルなC言語用Makefileのサンプルです。#で始まる行はコメントです。
# まず、make test をコマンドラインから実行すると、testセクションの前提となるリンクの$(TARGET):のセクションを実行しようとします。
# しかし$(TARGET):セクションはfunc.oとmain.oファイルが前提のため、何も生成していない状態でmake testを実行すると、
# コンパイルfunc.oの生成 -> コンパイルmain.oの生成 -> リンクfibの生成 -> テスト の順に実行されます。
# このようにMakefileでは、前提となるファイルが存在すればコンパイルはしないというように、必要なセクションだけが実行されるような仕組みになっています。
# makeコマンドは前提ファイルのタイムスタンプを見ている気がします。
#
# その他の処理も一度に全て実行したい場合には、make test && make clean のようにコマンドラインから実行します。
# コマンドラインからmakeのみでタグ名を指定せずに実行すると最初のセクションが実行されます。この例では$(TARGET):を実行しようとして、その結果コンパイルとリンクが実行されます。
# $^ はそのセクションの前提として記述したファイル名が代入されます。
#
# ではここからMakefileの始まりですー　そんなに難しくないから大丈夫ですよー
#
####
## add 2017/04/19
#変数定義
CC=gcc
CFLAGS=-std=c99 -c
TARGET=fib

#リンク
$(TARGET): func.o main.o
	$(CC) $^ -o $(TARGET)

#コンパイル
func.o: src/func.c
	$(CC) $(CFLAGS) $^ -o func.o

#コンパイル
main.o: src/main.c
	$(CC) $(CFLAGS) $^ -o main.o

#生成されたプログラムの実行（実行結果と予め用意したファイルをdiffコマンドで比較し結果を表示しています）
test: $(TARGET)
	@./$(TARGET) > output.txt
	@echo
	@echo ----------- Start of Test -----------
	@if diff output.txt test/answer.txt > /dev/null; then echo "test: OK :-)"; else echo "test: NG :-("; exit 1; fi
	@echo ------------ End of Test ------------

#その他の処理（さらにinstallといったタグのセクションを追加して導入用の処理を記述する事も一般的に行われます）
clean:
	rm -f *.o
	rm -f output.txt $(TARGET)
