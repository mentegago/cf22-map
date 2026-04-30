import 'package:cf_map_flutter/services/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umami_analytics/umami_analytics.dart';
import 'screens/map_screen.dart';
import 'services/analytics_service.dart';
import 'services/favorites_service.dart';
import 'services/creator_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final creatorDataProvider = CreatorDataProvider()..initialize();
  final favoritesService = FavoritesService(creatorDataProvider)..initialize();
  final settingsProvider = SettingsProvider()..initialize();

  runApp(CFMapApp(creatorDataProvider: creatorDataProvider, favoritesService: favoritesService, settingsProvider: settingsProvider));
}

class CFMapApp extends StatelessWidget {

  final CreatorDataProvider creatorDataProvider;
  final FavoritesService favoritesService;
  final SettingsProvider settingsProvider;
  const CFMapApp({super.key, required this.creatorDataProvider, required this.favoritesService, required this.settingsProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => creatorDataProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => favoritesService,
        ),
        ChangeNotifierProvider(
          create: (context) => settingsProvider,
        ),
      ],
      child: MaterialApp(
        title: 'CF22 Booth Map',
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF0050FF),
            onPrimary: Color(0xFFFFFFFF),
            primaryContainer: Color(0xFFCCDFFF),
            onPrimaryContainer: Color(0xFF001C7A),
            secondary: Color(0xFFE8006A),
            onSecondary: Color(0xFFFFFFFF),
            secondaryContainer: Color(0xFFFFD6E7),
            onSecondaryContainer: Color(0xFF5C001E),
            tertiary: Color(0xFF6600CC),
            onTertiary: Color(0xFFFFFFFF),
            tertiaryContainer: Color(0xFFE8D5FF),
            onTertiaryContainer: Color(0xFF260052),
            error: Color(0xFFDC2626),
            onError: Color(0xFFFFFFFF),
            errorContainer: Color(0xFFFEE2E2),
            onErrorContainer: Color(0xFF7F1D1D),
            surface: Color(0xFFFFFFFF),
            onSurface: Color(0xFF000510),
            surfaceContainerLowest: Color(0xFFF5F8FF),
            surfaceContainerLow: Color(0xFFEBF0FF),
            surfaceContainer: Color(0xFFDDE6FF),
            surfaceContainerHigh: Color(0xFFCDD8FF),
            surfaceContainerHighest: Color(0xFFBBC8FF),
            onSurfaceVariant: Color(0xFF1E2D5A),
            outline: Color(0xFF4A5699),
            outlineVariant: Color(0xFFA0AACC),
            shadow: Color(0xFF000000),
            scrim: Color(0xFF000000),
            inverseSurface: Color(0xFF0A1020),
            onInverseSurface: Color(0xFFE5E7EB),
            inversePrimary: Color(0xFF60A5FA),
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF0F5FF),
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF0F5FF),
            foregroundColor: Color(0xFF0050FF),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            showDragHandle: true,
          ),
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Color(0xFF60A5FA),
            onPrimary: Color(0xFF0C2A6E),
            primaryContainer: Color(0xFF1E3A8A),
            onPrimaryContainer: Color(0xFFBFDBFE),
            secondary: Color(0xFFF472B6),
            onSecondary: Color(0xFF500724),
            secondaryContainer: Color(0xFF831843),
            onSecondaryContainer: Color(0xFFFBCFE8),
            tertiary: Color(0xFFA78BFA),
            onTertiary: Color(0xFF1A0A5C),
            tertiaryContainer: Color(0xFF2D1B69),
            onTertiaryContainer: Color(0xFFDDD6FE),
            error: Color(0xFFF87171),
            onError: Color(0xFF7F1D1D),
            errorContainer: Color(0xFF991B1B),
            onErrorContainer: Color(0xFFFEE2E2),
            surface: Color(0xFF0E1E2E),
            onSurface: Color(0xFFE2E8F0),
            surfaceContainerLowest: Color(0xFF070F18),
            surfaceContainerLow: Color(0xFF0C1A28),
            surfaceContainer: Color(0xFF112232),
            surfaceContainerHigh: Color(0xFF162C40),
            surfaceContainerHighest: Color(0xFF1C3650),
            onSurfaceVariant: Color(0xFF94A3B8),
            outline: Color(0xFF475569),
            outlineVariant: Color(0xFF1E293B),
            shadow: Color(0xFF000000),
            scrim: Color(0xFF000000),
            inverseSurface: Color(0xFFE2E8F0),
            onInverseSurface: Color(0xFF0E1E2E),
            inversePrimary: Color(0xFF1D4ED8),
          ),
          useMaterial3: true,
          // Match map dark background so empty/panned areas are the same color
          scaffoldBackgroundColor: const Color(0xFF0A1B2A),
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0C1A28),
            foregroundColor: Color(0xFF60A5FA),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            showDragHandle: true,
          ),
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        themeMode: ThemeMode.system,
        navigatorObservers: [UmamiNavigatorObserver(analytics: umami)],
        home: const MapScreen(),
      ),
    );
  }
}
