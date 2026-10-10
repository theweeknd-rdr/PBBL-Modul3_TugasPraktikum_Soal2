import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/favorit_pilar_model.dart';
import 'pages/halaman_beranda.dart';
import 'pages/halaman_pilar.dart';
import 'pages/halaman_warga.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoritPilarModel>(
          create: (_) => FavoritPilarModel(),
        ),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nusantara Cerdas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2457A7)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE4EAF2)),
          ),
        ),
      ),
      home: const AplikasiUtama(),
    );
  }
}

class AplikasiUtama extends StatefulWidget {
  const AplikasiUtama({super.key});

  @override
  State<AplikasiUtama> createState() => _AplikasiUtamaState();
}

class _AplikasiUtamaState extends State<AplikasiUtama> {
  int _indeksTerpilih = 0;

  static const List<Widget> _halaman = [
    HalamanBeranda(),
    HalamanPilar(),
    HalamanWarga(),
  ];

  static const List<String> _judulHalaman = [
    'Beranda',
    'Pilar Smart City',
    'Ruang Warga',
  ];

  void _pilihHalaman(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.sizeOf(context).width;
    final layarLebar = lebar >= 800;
    final jumlahFavorit = context.select<FavoritPilarModel, int>(
      (model) => model.jumlahFavorit,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: layarLebar
            ? null
            : Builder(
                builder: (drawerContext) => IconButton(
                  tooltip: 'Buka menu navigasi',
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(drawerContext).openDrawer(),
                ),
              ),
        title: Text(_judulHalaman[_indeksTerpilih]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Tooltip(
                message: '$jumlahFavorit pilar favorit',
                child: Badge(
                  isLabelVisible: jumlahFavorit > 0,
                  label: Text('$jumlahFavorit'),
                  child: const Icon(Icons.star_outline),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: layarLebar
          ? null
          : NavigationDrawer(
              selectedIndex: _indeksTerpilih,
              onDestinationSelected: (indeks) {
                Navigator.of(context).pop();
                _pilihHalaman(indeks);
              },
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(28, 20, 16, 12),
                  child: Text(
                    'NUSANTARA CERDAS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                NavigationDrawerDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Beranda'),
                ),
                NavigationDrawerDestination(
                  icon: Icon(Icons.location_city_outlined),
                  selectedIcon: Icon(Icons.location_city),
                  label: Text('Pilar Smart City'),
                ),
                NavigationDrawerDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: Text('Ruang Warga'),
                ),
              ],
            ),
      body: layarLebar
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _indeksTerpilih,
                  onDestinationSelected: _pilihHalaman,
                  extended: lebar >= 1100,
                  labelType: lebar >= 1100
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  destinations: [
                    const NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.location_city_outlined),
                      selectedIcon: Icon(Icons.location_city),
                      label: Text('Pilar'),
                    ),
                    NavigationRailDestination(
                      icon: Badge(
                        isLabelVisible: jumlahFavorit > 0,
                        label: Text('$jumlahFavorit'),
                        child: const Icon(Icons.people_outline),
                      ),
                      selectedIcon: Badge(
                        isLabelVisible: jumlahFavorit > 0,
                        label: Text('$jumlahFavorit'),
                        child: const Icon(Icons.people),
                      ),
                      label: const Text('Warga'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: IndexedStack(
                    index: _indeksTerpilih,
                    children: _halaman,
                  ),
                ),
              ],
            )
          : IndexedStack(index: _indeksTerpilih, children: _halaman),
      bottomNavigationBar: layarLebar
          ? null
          : NavigationBar(
              selectedIndex: _indeksTerpilih,
              onDestinationSelected: _pilihHalaman,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.location_city_outlined),
                  selectedIcon: Icon(Icons.location_city),
                  label: 'Pilar',
                ),
                NavigationDestination(
                  icon: Badge(
                    isLabelVisible: jumlahFavorit > 0,
                    label: Text('$jumlahFavorit'),
                    child: const Icon(Icons.people_outline),
                  ),
                  selectedIcon: Badge(
                    isLabelVisible: jumlahFavorit > 0,
                    label: Text('$jumlahFavorit'),
                    child: const Icon(Icons.people),
                  ),
                  label: 'Warga',
                ),
              ],
            ),
    );
  }
}
