import 'dart:convert';

import 'package:domain/domain.dart';
import 'remote_config_wrapper.dart';

class RemoteConfigServiceImpl implements RemoteConfigService {
  final RemoteConfigWrapper _configWrapper;

  RemoteConfigServiceImpl({
    required RemoteConfigWrapper configWrapper,
  }) : _configWrapper = configWrapper;

  @override
  List<String> fetchListFromKey(String key) {
    final String value = _configWrapper.fetchString(key);

    if (value.isEmpty) {
      return <String>[];
    }

    return value.split(',').map((String e) => e.trim()).toList();
  }

  @override
  Map<String, dynamic> fetchJsonFromKey(String key) {
    final String jsonString = _configWrapper.fetchString(key);

    if (jsonString.isEmpty) {
      return <String, dynamic>{};
    }

    return jsonDecode(_configWrapper.fetchString(key));
  }
}
