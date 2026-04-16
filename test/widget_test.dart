import 'package:cf_map_flutter/services/creator_data_service.dart';
import 'package:cf_map_flutter/services/favorites_service.dart';
import 'package:cf_map_flutter/services/settings_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cf_map_flutter/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final creatorDataProvider = CreatorDataProvider()..initialize();
    final favoritesService = FavoritesService(creatorDataProvider)..initialize();
    final settingsProvider = SettingsProvider()..initialize();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(CFMapApp(creatorDataProvider: creatorDataProvider, favoritesService: favoritesService, settingsProvider: settingsProvider));

    // Verify that the app title is shown
    expect(find.text('CF22 Booth Map'), findsOneWidget);
  });
}

