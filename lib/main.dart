import 'package:flutter/material.dart';

const String studentName = 'I Kadek Agus Dwi Adnyana';
const String studentId = '2415051076';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahap 1 - Local vs Shared State',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
        useMaterial3: true,
      ),
      home: const StateClassificationPage(),
    );
  }
}

class StateClassificationPage extends StatefulWidget {
  const StateClassificationPage({super.key});

  @override
  State<StateClassificationPage> createState() =>
      _StateClassificationPageState();
}

class _StateClassificationPageState extends State<StateClassificationPage> {
  // Poin 7: Implementasi Local State dengan setState()
  bool isDetailVisible = false;
  bool isLocalFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tahap 1: Local vs Shared State'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Identitas Mahasiswa Praktikan
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'NIM: $studentId | PTI 5 A',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Poin 5 & 6: Ringkasan 5 State & Pengelompokannya
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Identifikasi & Klasifikasi 5 State:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildStateRow(
                        '1. Status Bookmark / Favorites',
                        'Shared State',
                        Colors.orange,
                      ),
                      _buildStateRow(
                        '2. Katalog Data Mata Kuliah',
                        'Shared State',
                        Colors.orange,
                      ),
                      _buildStateRow(
                        '3. Expand / Hide Rincian Kartu',
                        'Local State',
                        Colors.green,
                      ),
                      _buildStateRow(
                        '4. Indeks Tab Navigasi Aktif',
                        'Shared State',
                        Colors.orange,
                      ),
                      _buildStateRow(
                        '5. Teks Input Formulir Feedback',
                        'Local State',
                        Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Poin 7: Komponen Uji Local State (setState)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Flutter UI & Architecture',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isLocalFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isLocalFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isLocalFavorite = !isLocalFavorite;
                              });
                            },
                          ),
                        ],
                      ),
                      const Text(
                        'MOB05 • 3 SKS • Status: Active',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            isDetailVisible = !isDetailVisible;
                          });
                        },
                        icon: Icon(
                          isDetailVisible
                              ? Icons.expand_less
                              : Icons.expand_more,
                        ),
                        label: Text(
                          isDetailVisible
                              ? 'Sembunyikan Rincian'
                              : 'Tampilkan Rincian (setState)',
                        ),
                      ),
                      if (isDetailVisible) ...[
                        const Divider(height: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Rincian ini dikontrol oleh local state (isDetailVisible). Saat tombol ditekan, hanya widget ini yang dibangun ulang melalui setState().',
                            style: TextStyle(fontSize: 13, height: 1.4),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildStateRow(String name, String type, Color badgeColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 13)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              type,
              style: TextStyle(
                color: badgeColor,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
