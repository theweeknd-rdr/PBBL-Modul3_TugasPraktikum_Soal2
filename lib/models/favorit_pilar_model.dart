import 'package:flutter/foundation.dart';

/// State bersama yang dipakai oleh halaman Pilar dan Warga.
class FavoritPilarModel extends ChangeNotifier {
  final Set<String> _favorit = <String>{};

  List<String> get daftarFavorit => List.unmodifiable(_favorit);

  int get jumlahFavorit => _favorit.length;

  bool isFavorit(String namaPilar) => _favorit.contains(namaPilar);

  void toggleFavorit(String namaPilar) {
    if (_favorit.contains(namaPilar)) {
      _favorit.remove(namaPilar);
    } else {
      _favorit.add(namaPilar);
    }
    notifyListeners();
  }

  void hapusFavorit(String namaPilar) {
    if (_favorit.remove(namaPilar)) {
      notifyListeners();
    }
  }
}
