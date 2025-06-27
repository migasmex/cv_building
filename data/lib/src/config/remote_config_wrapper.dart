import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigWrapper {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigWrapper({
    required FirebaseRemoteConfig remoteConfig,
  }) : _remoteConfig = remoteConfig;

  String fetchString(String key) {
    return _remoteConfig.getString(key);
  }
}
