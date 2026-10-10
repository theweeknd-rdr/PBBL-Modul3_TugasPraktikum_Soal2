import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_pilar_model.dart';

class _PilarInfo {
  const _PilarInfo({
    required this.nama,
    required this.deskripsi,
    required this.ikon,
  });

  final String nama;
  final String deskripsi;
  final IconData ikon;
}

class HalamanPilar extends StatelessWidget {
  const HalamanPilar({super.key});

  static const List<_PilarInfo> _daftarPilar = [
    _PilarInfo(
      nama: 'Smart Governance',
      deskripsi: 'Layanan publik dan pemerintahan yang transparan.',
      ikon: Icons.account_balance_outlined,
    ),
    _PilarInfo(
      nama: 'Smart Economy',
      deskripsi: 'Ekonomi digital dan peluang usaha masyarakat.',
      ikon: Icons.trending_up,
    ),
    _PilarInfo(
      nama: 'Smart Living',
      deskripsi: 'Kualitas hidup, kesehatan, dan kenyamanan warga.',
      ikon: Icons.home_work_outlined,
    ),
    _PilarInfo(
      nama: 'Smart Mobility',
      deskripsi: 'Transportasi dan mobilitas yang terintegrasi.',
      ikon: Icons.directions_bus_outlined,
    ),
    _PilarInfo(
      nama: 'Smart Environment',
      deskripsi: 'Lingkungan bersih dan pemanfaatan sumber daya.',
      ikon: Icons.eco_outlined,
    ),
    _PilarInfo(
      nama: 'Smart People',
      deskripsi: 'Warga yang terampil, kreatif, dan berpartisipasi.',
      ikon: Icons.groups_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // watch() membuat daftar mengikuti perubahan data favorit.
    final favoritModel = context.watch<FavoritPilarModel>();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Pilar Smart City',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        const Text('Tekan ikon bintang untuk menyimpan atau menghapus favorit.'),
        const SizedBox(height: 16),
        for (final pilar in _daftarPilar)
          Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                child: Icon(pilar.ikon),
              ),
              title: Text(
                pilar.nama,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(pilar.deskripsi),
              ),
              trailing: IconButton(
                tooltip: favoritModel.isFavorit(pilar.nama)
                    ? 'Hapus dari favorit'
                    : 'Tambahkan ke favorit',
                icon: Icon(
                  favoritModel.isFavorit(pilar.nama)
                      ? Icons.star
                      : Icons.star_border,
                  color: favoritModel.isFavorit(pilar.nama)
                      ? Colors.amber.shade800
                      : null,
                ),
                // read() memanggil aksi tanpa membuat callback menjadi listener.
                onPressed: () => context
                    .read<FavoritPilarModel>()
                    .toggleFavorit(pilar.nama),
              ),
            ),
          ),
      ],
    );
  }
}
