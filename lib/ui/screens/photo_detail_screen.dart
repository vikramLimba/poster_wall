import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:poster_wall/data/model/photo_model.dart';

class PhotoDetailScreen extends StatelessWidget {
  final PhotoModel photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(photo.photographer ?? 'Photo Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: photo.image,
              fit: BoxFit.cover,
              height: 400,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (photo.photographerId != null &&
                      photo.photographerId != "") ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Photographer id: ${photo.photographerId}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],

                  if (photo.photographer != null &&
                      photo.photographer != "") ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),

                      child: Text(
                        'Photographer: ${photo.photographer}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                  if (photo.alt != null && photo.alt != "") ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Description: ${photo.alt}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
