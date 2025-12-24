import 'package:get_storage/get_storage.dart';

class FavoriteStorage {
  final _box = GetStorage();

  void save(List<dynamic> data) {
    _box.write('favorites', data);
  }

  List<dynamic> load() {
    return _box.read('favorites') ?? [];
  }
}
