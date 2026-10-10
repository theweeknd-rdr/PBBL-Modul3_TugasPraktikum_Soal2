import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_pilar_model.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  // State lokal: hanya dibutuhkan untuk mengatur ringkasan di halaman ini.
  bool _tampilkanRingkasan = true;

  @override
  Widget build(BuildContext context) {
    final jumlahFavorit = context.select<FavoritPilarModel, int>(
      (model) => model.jumlahFavorit,
    );

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_city, color: Colors.white, size: 38),
              const SizedBox(height: 14),
              Text(
                'Nusantara Cerdas',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Menuju kota yang terhubung, nyaman, dan berkelanjutan.',
                style: TextStyle(color: Colors.white, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  child: const Icon(Icons.star, size: 27),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$jumlahFavorit pilar favorit',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 3),
                      const Text('Pilih pilar di menu Pilar, lalu lihat hasilnya di menu Warga.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          child: Column(
            children: [
              SwitchListTile.adaptive(
                value: _tampilkanRingkasan,
                title: const Text('Tampilkan ringkasan pilar'),
                subtitle: const Text('Contoh state lokal menggunakan setState()'),
                secondary: const Icon(Icons.visibility_outlined),
                onChanged: (nilaiBaru) {
                  setState(() {
                    _tampilkanRingkasan = nilaiBaru;
                  });
                },
              ),
              if (_tampilkanRingkasan)
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Smart City menghubungkan pemerintahan, ekonomi, '
                      'kehidupan, mobilitas, lingkungan, dan masyarakat '
                      'melalui layanan yang lebih baik.',
                      style: TextStyle(height: 1.5),
                    ),
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Ringkasan sedang disembunyikan.'),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Cara mencoba',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        const Text(
          '1. Buka menu Pilar dan tekan ikon bintang pada satu atau beberapa pilar.\n'
          '2. Buka menu Warga untuk melihat daftar favorit.\n'
          '3. Hapus favorit dari menu Warga dan periksa perubahan di halaman lain.',
          style: TextStyle(height: 1.6),
        ),
      ],
    );
  }
}
