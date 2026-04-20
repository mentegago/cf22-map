import 'package:http/http.dart' as http;
import 'package:umami_analytics/umami_analytics.dart';

const _websiteId = String.fromEnvironment('UMAMI_WEBSITE_ID', defaultValue: '');
const _endpoint = String.fromEnvironment('UMAMI_ENDPOINT', defaultValue: '');
const _hostname = String.fromEnvironment('UMAMI_HOSTNAME', defaultValue: '');
const _analyticsConfigured = _websiteId != '' && _endpoint != '' && _hostname != '';

// Strips the User-Agent header set by umami_analytics — setting it from a
// browser context triggers CORS preflight failures on Firefox.
class _NoUserAgentClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.remove('User-Agent');
    return _inner.send(request);
  }
}

final UmamiAnalytics umami = UmamiAnalytics(
  websiteId: _websiteId,
  endpoint: _endpoint,
  hostname: _hostname,
  enabled: _analyticsConfigured,
  queueConfig: const UmamiQueueInMemory(),
  httpClient: _NoUserAgentClient(),
);
