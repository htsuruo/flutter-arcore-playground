# flutter_arcore_geospatial_playground

## Checklist

- [x] [arcore_flutter_plugin](https://pub.dev/packages/arcore_flutter_plugin)
- [ ] [ar_flutter_plugin](https://pub.dev/packages/ar_flutter_plugin)
- [ ] [flutter_unity_widget](https://pub.dev/packages/flutter_unity_widget)
- [ ] [flutter_embed_unity](https://pub.dev/packages/flutter_embed_unity)

## ARCore関連のFlutterパッケージ

- [arcore_flutter_plugin | Flutter package](https://pub.dev/packages/arcore_flutter_plugin)
  - 非公式パッケージで対応は***Androidのみ***
  - iOSサポートはイシュー化されているものの当面対応は期待できなさそう
    - ref. [giandifra/arcore_flutter_plugin#18](https://github.com/giandifra/arcore_flutter_plugin/issues/18)
  - 2024.07時点Kotlinバージョン周りの問題で最新masterでしかビルドが成功しない点に注意
  - [Issueもたくさん残っており](https://github.com/giandifra/arcore_flutter_plugin/issues)最近はあまり改善なさそう
  - `ArNode`のHot Reloadも効かないので開発しづらい
  - Hot Restartを試みるとExitedとなりアプリケーションが終了してしまう問題
    - ref. [giandifra/arcore_flutter_plugin#231](https://github.com/giandifra/arcore_flutter_plugin/issues/231)
- arcore_flutter_pluginを使ったGeometric Shapesを配置するサンプル動画（Youtube）
  - [(93) ARCore Flutter Tutorial | Sceneform Android Studio | AR Geometric Shapes App | arcore_flutter_plugin - YouTube](https://www.youtube.com/watch?v=ks1Ko7i-QO0)
- [ar_flutter_plugin | Flutter package](https://pub.dev/packages/ar_flutter_plugin)
  - [arkit_plugin | Flutter package](https://pub.dev/packages/arkit_plugin) と[arcore_flutter_plugin | Flutter package](https://pub.dev/packages/arcore_flutter_plugin)を組み合わせて、iOS・Android両対応できるようにしたもの
  - ARCore自体iOSも対応しているが、専用のパッケージがないのでARKitと併用しているということだろう

## FlutterでAR開発する様々な選択肢

- FlutterでARアプリを開発する場合は、ARKitとARCoreの合せ技が主流?
  - 前述の`ar_flutter_plugin`使えば比較的簡単に実現できそう
  - > FlutterにARKitとARCoreを組み合わせれば、Android向けとiOS向けのARアプリを同じコードベースで開発できるのではないか
  - [[Flutter開発]FlutterとARCoreを組み合わせてAndroidのARアプリを作成してみる #Dart - Qiita](https://qiita.com/s_harada/items/44c50ea22d006b972897)

### Unityとの組み合わせ

- Unity as a LibraryでFlutterに組み込む
  - Unity as a LibraryはUnityプロジェクトをiOS・Android・WebGLなどにエクスポートできる機能
  - iOS・Androidにエクスポートし、MethodChannelでFlutterから呼び出す方法
    - [juicycleff/flutter-unity-view-widget](https://github.com/juicycleff/flutter-unity-view-widget)が有名みたい（[flutter_unity_widget | Flutter package](https://pub.dev/packages/flutter_unity_widget)）
    - Flutter Engineの上でUnityの3Dオブジェクトを表示しインタラクティブ操作も可能
    - `postMessage`メソッドが肝でMethodChannel使っている
      - 1. [postMessageのDart実装](https://github.com/juicycleff/flutter-unity-view-widget/blob/45fffb52e5e2c101bda435e396218b2ad9c56503/lib/src/io/device_method.dart#L248)
      - 2. [プラットフォーム側の実装](https://github.com/juicycleff/flutter-unity-view-widget/blob/45fffb52e5e2c101bda435e396218b2ad9c56503/android/src/main/kotlin/com/xraph/plugin/flutter_unity_widget/FlutterUnityWidgetController.kt#L132)
      - 3. `UnityPlayer.UnitySendMessage`でUnity関数をコール
        - ref. [UnityでiOSとAndroidのネイティブプラグインを作るのは怖くない！ – cocone engineering](https://engineering.cocone.io/2023/11/14/unity-ios-android-native-plugin/)
    - 活用事例
      - ref. [tetsujp84/flutter_uaal](https://github.com/tetsujp84/flutter_uaal?tab=readme-ov-file)
    - 他にも調べてみたら最近のパッケージで[flutter_embed_unity | Flutter package](https://pub.dev/packages/flutter_embed_unity)も良さそう
- FlutterをAdd-to-appでUnityに組み込む
  - ref. [Flutter「を」Unity「へ」導入する | gihyo.jp](https://gihyo.jp/article/2024/04/flutter-unity-01)

## Geospatial API関連

- Geospatial API自体はFlutterの公式パッケージが存在しない模様
  - 公式サイトに記載がなく、pub.devで探してみても野良のパッケージすら存在しない
  - [Build global-scale, immersive, location-based AR experiences with the ARCore Geospatial API  |  Google for Developers](https://developers.google.com/ar/develop/geospatial)
- `ar_flutter_plugin`は[sceneview_flutter | Flutter package](https://pub.dev/packages/sceneview_flutter)でGeospatial APIに対応しているコメントあり（ただしこちらもサポートはAndroidのみ）
  - SceneViewの正体を探るところからだが、SceneFormというのが古い実装でSceneViewが新しい実装という位置づけぽい
  - ref. https://github.com/giandifra/arcore_flutter_plugin/issues/203#issuecomment-1422434555
  - しかもまだSkelton状態とのこと
    - ref. https://github.com/giandifra/arcore_flutter_plugin/issues/202#issuecomment-1418755851

## ARCore Platform Setup

### Android

- [Configure your app](https://pub.dev/packages/arcore_flutter_plugin#configure-your-app)の通り

### Kotlin Gradle plugin version 1.5.20 and higher

> - What went wrong:
The Android Gradle plugin supports only Kotlin Gradle plugin version 1.5.20 and higher.
The following dependencies do not satisfy the required version:
project ':arcore_flutter_plugin' -> org.jetbrains.kotlin:kotlin-gradle-plugin:1.3.50

### iOS

- Google CloudでのARCore APIの有効化
  - [Use the ARCore API on Google Cloud  |  Google for Developers](https://developers.google.com/ar/develop/authorization?platform=ios)
- CocoapodsまたはSwift Package ManagerでARCoreライブラリのインストール
  - [Geospatial API](https://developers.google.com/ar/develop/geospatial)を使用する場合は、`pod 'ARCore/Geospatial'`と指定
- [Enable AR in your iOS app  |  ARCore  |  Google for Developers](https://developers.google.com/ar/develop/ios/enable-arcore)

#### `pod 'ARCore/Geospatial'`を指定して`pod install`した時に発生したエラー

> [!] The following Swift pods cannot yet be integrated as static libraries:

> The Swift pod `FirebaseCoreInternal-library` depends upon `GoogleUtilities-library`, which does not define modules. To opt into those targets generating module maps (which is necessary to import them from Swift when building as static libraries), you may set `use_modular_headers!` globally in your Podfile, or specify `:modular_headers => true` for particular dependencies.

> The Swift pod `FirebaseRemoteConfig-library` depends upon `FirebaseABTesting-library`, `FirebaseCore-library`, `FirebaseInstallations-library`, and `GoogleUtilities-library`, which do not define modules. To opt into those targets generating module maps (which is necessary to import them from Swift when building as static libraries), you may set `use_modular_headers!` globally in your Podfile, or specify `:modular_headers => true` for particular dependencies.

targetに記載されていた`use_modular_headers!`をグローバルに配置して解消

```pod
target 'Runner' do
  use_frameworks!
  # use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
  target 'RunnerTests' do
    inherit! :search_paths
  end
end
```

↓

```pod
# Uncomment this line to define a global platform for your project
platform :ios, '12.0'
pod 'ARCore/Geospatial'

use_modular_headers!
```
