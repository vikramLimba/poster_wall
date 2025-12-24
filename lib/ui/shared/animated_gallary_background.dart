import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnimatedGalleryBackground extends StatefulWidget {
  final List<String> imageUrls;

  const AnimatedGalleryBackground({super.key, required this.imageUrls});

  @override
  State<AnimatedGalleryBackground> createState() =>
      _AnimatedGalleryBackgroundState();
}

class _AnimatedGalleryBackgroundState extends State<AnimatedGalleryBackground> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      if (!_scrollController.hasClients) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final nextOffset = _scrollController.offset + 0.5;

      if (nextOffset >= maxScroll) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(nextOffset);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      child: MasonryGridView.count(
        padding: EdgeInsets.zero,
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,

        itemCount: widget.imageUrls.length,
        itemBuilder: (_, i) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrls[i],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
