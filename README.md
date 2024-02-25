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

### Xcode でビルド

1. cocoapods をインストールする。
   // ドライブ直下で実施。基本 brew コマンドで実施してください。
   brew install cocoapods
   // or
   sudo gem install cocoapods

2. でビルドに失敗する場合、以下のコマンドを実施する。
   https://flutter.salon/error_warning/flutter-build-ios/

// 本ディレクトリ直下で実施。
flutter clean

// ios フォルダで実施
cd ios
rm -rf Pods Podfile.lock
pod repo update

// 本ディレクトリ直下で実施。
cd ../
flutter pub get

// ios フォルダで実施
cd ios
pod install

// 本ディレクトリ直下で実施。
flutter run

3. 上記で正常にいかない場合、Xcode のキャッシュを削除する。
   この Mac について > 詳細情報 > ストレージ設定 > デベロッパ > XCode プロジェクトのキャッシュを削除

## Implementation

# 1.view model, provider は自動生成を使用しています。以下のコマンドを実施してください。

flutter pub run build_runner build --delete-conflicting-outputs

ビルド失敗した際に、過去の破損したパッケージが原因の可能性あり。下記実施。
flutter pub cache repair

## DB path

# SQLite の DB 格納先（MAC）は以下に配置されます。初期化したい場合は、stairs.sqlite を削除し、サーバーを起動してください。（新規作成されます。）

/Users/xxxxxxxx/Library/Containers/com.example.stairs/Data/Documents/stairs.sqlite

## 拡張機能

1. Flutter
2. Dart
3. SQLite
4. Code Spell Checker
