import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_pilar_model.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritPilarModel>(
      builder: (context, model, child) {
        final daftarFavorit = model.daftarFavorit;

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Ruang Warga',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            const Text('Daftar pilar yang kamu simpan sebagai favorit.'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Pilar Favorit (${model.jumlahFavorit})',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                if (daftarFavorit.isNotEmpty)
                  TextButton.icon(
                    onPressed: () {
                      for (final nama in List<String>.from(daftarFavorit)) {
                        model.hapusFavorit(nama);
                      }
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Hapus semua'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (daftarFavorit.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 54,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Belum ada pilar favorit',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Buka menu Pilar dan tekan ikon bintang untuk menambahkan favorit.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              for (final nama in daftarFavorit)
                Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(nama),
                    trailing: IconButton(
                      tooltip: 'Hapus dari favorit',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => context
                          .read<FavoritPilarModel>()
                          .hapusFavorit(nama),
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }
}
