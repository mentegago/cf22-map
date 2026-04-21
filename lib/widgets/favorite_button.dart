import 'package:cf_map_flutter/models/creator.dart';
import 'package:cf_map_flutter/services/analytics_service.dart';
import 'package:cf_map_flutter/services/favorites_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.creator,
  });

  final Creator creator;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select((FavoritesService favoritesService) =>
        favoritesService.isFavorited(creator.id));
    final isStorageAvailable = context.select(
        (FavoritesService favoritesService) =>
            favoritesService.isStorageAvailable);
    final theme = Theme.of(context);

    if (!isStorageAvailable) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.pink : theme.iconTheme.color,
      ),
      tooltip: isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
      onPressed: () async {
        umami.trackEvent(
          name: 'creator_favorite_tapped',
          data: {
            'creator_id': creator.id.toString(),
            'creator_name': creator.name,
            'favorited': (!isFavorite).toString(),
          },
        );

        if (creator.id == -1) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Favorites feature is currently unavailable. We\'ll add this back as soon as we can!',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        if (isFavorite) {
          context.read<FavoritesService>().removeFavorite(creator.id);
        } else {
          context.read<FavoritesService>().addFavorite(creator.id);
        }
      },
    );
  }
}
