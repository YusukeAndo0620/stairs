# stairs

エンジニアのためのタスク管理アプリとなります。

## Getting Started

clone が完了したら、ターミナルで以下のコマンドを実施してください。

1. flutter をインストールしてください。https://www.sejuku.net/blog/123973
   1.1 Flutter SDK をダウンロード
   1.2 解凍した後、任意のフォルダに移動し、パスを通す(自分は develop フォルダを home 直下に作成し移動。以下 Mac 端末の場合)
   export PATH=~/xxxxxx/flutter/bin:$PATH
   source ~/.bash_profile
   1.3 「flutter doctor」をコマンドで実施し、開発に必要なパッケージを確認。
2. flutter pub get (flutter packages get)
3. flutter clean
4. flutter run(ログ見たいなら、flutter run --verbose)

## Implementation

# 1.view model には自動生成を使用します。以下のコマンドを実施してください。

flutter pub run build_runner build --delete-conflicting-outputs

ビルド失敗した際に、過去の破損したパッケージが原因の可能性あり。下記実施。
flutter pub cache repair

## DB path

# SQLite の DB 格納先（MAC）は以下に配置されます。

/Users/xxxxxxxx/Library/Containers/com.example.stairs/Data/Documents/db.sqlite
