import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:poster_wall/controllers/gallary_controller.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final controller = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: Obx(() {
        final favPhotos = controller.favoritePhotos;

        if (favPhotos.isEmpty) {
          return const Center(child: Text('No favorites yet'));
        }

        return MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: favPhotos.length,
          itemBuilder: (_, i) {
            final photo = favPhotos[i];
            return GestureDetector(
              onTap: () => controller.toggleFavorite(photo),
              child: Stack(
                children: [
                  CachedNetworkImage(imageUrl: photo.image),
                  const Positioned(
                    right: 8,
                    top: 8,
                    child: Icon(Icons.favorite, color: Colors.red),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
