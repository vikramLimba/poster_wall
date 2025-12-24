import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_wall/data/api/pexel_api.dart';
import '../data/model/photo_model.dart';
import '../data/storage/favorite_storage.dart';

class GalleryController extends GetxController {
  final api = PexelsApi(
    'OUj6aX0mvquClOR2GBOW760FxppEiD6MwigNFkI1Nf9BCpvo8PGOt8io',
  );
  final favoritesStorage = FavoriteStorage();

  var photos = <PhotoModel>[].obs;

  var favoritePhotos = <PhotoModel>[].obs;

  var page = 1;
  var query = ''.obs;
  var isLoading = false.obs;

  Timer? _debounce;

  final ScrollController scrollController = ScrollController();

  final backgroundImages = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    final stored = favoritesStorage.load();
    favoritePhotos.value = stored
        .whereType<Map<String, dynamic>>()
        .map((e) => PhotoModel.fromJson(e))
        .toList();

    fetch(reset: true);

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !isLoading.value) {
        fetch();
      }
    });
  }

  Future<void> loadCuratedBackground() async {
    if (backgroundImages.isNotEmpty) return;

    final data = await api.fetchCurated(5);
    backgroundImages.assignAll(
      data.map((e) => e['src']['medium'] as String).toList(),
    );
  }

  void onSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      query.value = value;
      fetch(reset: true);
    });
  }

  Future<void> fetch({bool reset = false}) async {
    if (reset) {
      page = 1;
      photos.clear();
    }

    if (isLoading.value) return;

    isLoading.value = true;
    final data = await api.search(query.value, page);

    photos.addAll(data.map((e) => PhotoModel.fromJson(e)).toList());

    page++;
    isLoading.value = false;
  }

  Future<void> refresh() async => fetch(reset: true);

  bool isFavorite(PhotoModel photo) {
    return favoritePhotos.any((p) => p.id == photo.id);
  }

  void toggleFavorite(PhotoModel photo) {
    final index = favoritePhotos.indexWhere((p) => p.id == photo.id);

    if (index >= 0) {
      favoritePhotos.removeAt(index);
    } else {
      favoritePhotos.add(photo);
    }

    favoritesStorage.save(favoritePhotos.map((e) => e.toJson()).toList());
  }
}
