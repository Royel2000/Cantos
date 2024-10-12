import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../models/songs_model.dart';
import '../providers/songs_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // title: Text(
        //   "Cancionero",
        //   style: TextStyle(color: Theme.of(context).colorScheme.primary),
        // ),
        //switch darkTheme
        // actions: [
        //   Consumer<ThemeProvider>(
        //     builder: (context, themeProvider, child) {
        //       return Switch(
        //         value: themeProvider.themeMode == ThemeMode.dark,
        //         onChanged: (value) {
        //           themeProvider.toggleTheme(value);
        //         },
        //       );
        //     },
        //   ),
        // ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(5, 5),
                        blurRadius: 10,
                        spreadRadius: 1),
                    const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, -5),
                        blurRadius: 10,
                        spreadRadius: 1)
                  ]),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar Estribillos',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Consumer<SongsProvider>(
          builder: (context, songProvider, child) {
            return FutureBuilder<List<SongModel>>(
              future: songProvider.cargarSongs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                var songs = snapshot.data!;
                if (_searchText.isNotEmpty) {
                  songs = songs
                      .where((song) => "${song.id} ${song.title}"
                          .toLowerCase()
                          .contains(_searchText.toLowerCase()))
                      .toList();
                }
                if (songs.isEmpty) {
                  return Center(
                    child: Text(
                      "No hay ninguna coincidencia",
                      style: GoogleFonts.openSans(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: songProvider.cargarSongs,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    itemCount: songs.length,
                    itemBuilder: (context, i) => _crearItem(context, songs[i]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _crearItem(BuildContext context, SongModel song) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 1),
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
          child: ListTile(
            title: Text(
              "${song.id}.- ${song.title}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/infocanto", arguments: song);
            },
          ),
        ),
      ),
    );
  }
}
