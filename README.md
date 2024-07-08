# flutter_arcore_geospatial_playground

- [arcore_flutter_plugin | Flutter package](https://pub.dev/packages/arcore_flutter_plugin)
  - 非公式パッケージ
- arcore_flutter_pluginを使ったGeometric Shapesを配置するサンプル動画（Youtube）
  - [(93) ARCore Flutter Tutorial | Sceneform Android Studio | AR Geometric Shapes App | arcore_flutter_plugin - YouTube](https://www.youtube.com/watch?v=ks1Ko7i-QO0)
- Geospatial API自体はFlutterの公式パッケージが存在しない模様
  - [Build global-scale, immersive, location-based AR experiences with the ARCore Geospatial API  |  Google for Developers](https://developers.google.com/ar/develop/geospatial)

## ARCore Platform Setup

Google CloudでのARCore APIの有効化
[Use the ARCore API on Google Cloud  |  Google for Developers](https://developers.google.com/ar/develop/authorization?platform=ios)

### iOS

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
