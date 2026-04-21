import 'package:umami_analytics/umami_analytics.dart';

const _websiteId = String.fromEnvironment('UMAMI_WEBSITE_ID', defaultValue: '');
const _endpoint = String.fromEnvironment('UMAMI_ENDPOINT', defaultValue: '');
const _hostname = String.fromEnvironment('UMAMI_HOSTNAME', defaultValue: '');
const _analyticsConfigured = _websiteId != '' && _endpoint != '' && _hostname != '';

final UmamiAnalytics umami = UmamiAnalytics(
  websiteId: _websiteId,
  endpoint: _endpoint,
  hostname: _hostname,
  enabled: _analyticsConfigured,
  queueConfig: const UmamiQueueInMemory()
);
