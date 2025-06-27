abstract class RemoteConfigService {
  List<String> fetchListFromKey(String key);
  Map<String, dynamic> fetchJsonFromKey(String key);
}
