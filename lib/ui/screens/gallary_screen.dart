import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:poster_wall/controllers/gallary_controller.dart';
import 'package:poster_wall/ui/screens/photo_detail_screen.dart';
import 'package:poster_wall/ui/shared/custom_textfield.dart';
import 'package:poster_wall/utilities/style/app_colors.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});

  final controller = Get.put(GalleryController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poster Wall'),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomTextfield(
              hintText: 'Search...',
              hintTextStyle: TextStyle(
                fontSize: 14,
                color: AppColors.textColor,
              ),
              textStyle: TextStyle(color: AppColors.textColor, fontSize: 14),
              onChanged: controller.onSearch,
            ),
          ),
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: controller.refresh,
                child: MasonryGridView.count(
                  controller: controller.scrollController,
                  crossAxisCount: 2,
                  itemCount: controller.photos.length,
                  itemBuilder: (_, i) {
                    final photo = controller.photos[i];
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          Get.to(() => PhotoDetailScreen(photo: photo));
                        },
                        child: Stack(
                          children: [
                            CachedNetworkImage(imageUrl: photo.image),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: GestureDetector(
                                onTap: () => controller.toggleFavorite(photo),

                                child: Icon(
                                  controller.isFavorite(photo)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
