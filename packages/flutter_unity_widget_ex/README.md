# flutter_unity_widget_ex

### could not be found in project ':unityLibrary'

- おそらく大抵は遭遇する
  - ref. https://github.com/juicycleff/flutter-unity-view-widget/issues/844#issuecomment-1640963178
- `settings.gradle`に以下を追記で解消

```gradle
include ':unityLibrary:xrmanifest.androidlib'
```

### [CXX1100] Both android.ndkPath and ndk.dir in local.properties are set

- シンプルに`local.properties`の記載を削除すれば良い（ドキュメント通り実行すると必ず遭遇する）
  - ref. https://github.com/juicycleff/flutter-unity-view-widget/issues/832#issuecomment-1627557580
