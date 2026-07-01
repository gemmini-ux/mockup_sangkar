import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';
import 'package:mocupsangkar/features/mockup01/models/sangkar_models.dart';
import 'package:mocupsangkar/features/mockup01/features/template/template_page.dart';

class DataSangkarPage extends StatefulWidget {
  final Color accentColor;
  final Color cardColor;
  final Color backgroundColor;
  final bool isLightTheme;

  const DataSangkarPage({
    super.key,
    this.accentColor = Colors.cyanAccent,
    this.cardColor = const Color(0xFF101B2D),
    this.backgroundColor = const Color(0xFF0C0A19),
    this.isLightTheme = false,
  });

  @override
  State<DataSangkarPage> createState() => _DataSangkarPageState();
}

class _DataSangkarPageState extends State<DataSangkarPage> {
  final SangkarController _controller = Get.find<SangkarController>();
  String _selectedCategory = 'Semua Kategori';
  String _searchQuery = '';
  JenisSangkar? _selectedCage;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final listCages = _controller.cages;

      if (_selectedCage != null) {
        // Render physical cage detail blueprint view
        return _buildCageDetailView(_selectedCage!);
      }

      final filteredCages = listCages.where((c) {
        final matchSearch = c.nama.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchCategory = _selectedCategory == 'Semua Kategori' ||
            (c.nama.toLowerCase().contains(_selectedCategory.toLowerCase()) || 
             _getCageCategory(c) == _selectedCategory);
        return matchSearch && matchCategory;
      }).toList();

      final totalCount = listCages.length;

      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DATA SANGKAR & SPESIFIKASI',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kelola kerangka, bagian-bagian, bentuk, dan ukuran sangkar fisik',
                      style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5)),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => _tampilkanDialogSangkarBaru(context),
                  icon: const Icon(Icons.add, size: 14, color: Colors.black),
                  label: const Text('Kerangka Baru', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search Bar & Filters
            Container(
              padding: const EdgeInsets.all(12),
              decoration: _glassDecoration(),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      decoration: InputDecoration(
                        hintText: 'Cari tipe sangkar...',
                        hintStyle: const TextStyle(color: Colors.white30, fontSize: 12),
                        prefixIcon: const Icon(Icons.search, size: 16, color: Colors.cyanAccent),
                        filled: true,
                        fillColor: const Color(0xFF101B2D),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      ),
                      onChanged: (val) => setState(() => _searchQuery = val),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Categories & Grid list panel
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Category selector
                SizedBox(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLeftMenuSection('Kategori Kerangka', [
                        _buildCategoryRow('Semua Kategori', totalCount, Icons.grid_view_rounded),
                        _buildCategoryRow('kosan', listCages.where((c) => _getCageCategory(c) == 'kosan').length, Icons.square_foot_outlined),
                        _buildCategoryRow('diamond', listCages.where((c) => _getCageCategory(c) == 'diamond').length, Icons.auto_awesome_outlined),
                        _buildCategoryRow('tebok', listCages.where((c) => _getCageCategory(c) == 'tebok').length, Icons.circle_outlined),
                        _buildCategoryRow('bijian', listCages.where((c) => _getCageCategory(c) == 'bijian').length, Icons.grid_on_outlined),
                        _buildCategoryRow('BP', listCages.where((c) => _getCageCategory(c) == 'BP').length, Icons.token_outlined),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Center Column: Cages Grid
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: _glassDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daftar Kerangka Fisik (${filteredCages.length})',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        filteredCages.isEmpty
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40),
                                  child: Text('Tidak ada kerangka sangkar.', style: TextStyle(color: Colors.white30, fontSize: 12)),
                                ),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: filteredCages.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.85,
                                ),
                                itemBuilder: (context, idx) {
                                  final c = filteredCages[idx];
                                  return _buildCageGridCard(c);
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  String _getCageCategory(JenisSangkar c) {
    final cleanName = c.nama.toLowerCase();
    if (cleanName.contains('kosan')) return 'kosan';
    if (cleanName.contains('diamond')) return 'diamond';
    if (cleanName.contains('tebok')) return 'tebok';
    if (cleanName.contains('bijian')) return 'bijian';
    if (cleanName.contains('bp') || cleanName.contains('pitoyo') || cleanName.contains('timbul')) return 'BP';
    return 'kosan'; // default fallback
  }

  Widget _buildCageGridCard(JenisSangkar c) {
    final cat = _getCageCategory(c);
    Color themeColor = Colors.orangeAccent;
    if (cat == 'diamond') themeColor = Colors.cyanAccent;
    if (cat == 'tebok') themeColor = Colors.purpleAccent;
    if (cat == 'bijian') themeColor = Colors.greenAccent;
    if (cat == 'BP') themeColor = Colors.pinkAccent;

    return InkWell(
      onTap: () => setState(() => _selectedCage = c),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1626),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wireframe Preview
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF060D1A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomPaint(
                  painter: BirdcageFramePainter(shape: c.bentuk, color: themeColor.withValues(alpha: 0.7)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: themeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: themeColor.withValues(alpha: 0.3), width: 0.5),
              ),
              child: Text(
                cat.toUpperCase(),
                style: TextStyle(fontSize: 7, color: themeColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              c.nama,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              '${c.bentuk} • ${c.bagian.length} Komponen',
              style: const TextStyle(fontSize: 9, color: Colors.white38),
            ),
            const SizedBox(height: 2),
            Text(
              c.ukuranTotal,
              style: const TextStyle(fontSize: 9, color: Colors.cyanAccent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCageDetailView(JenisSangkar c) {
    final cat = _getCageCategory(c);
    Color themeColor = Colors.orangeAccent;
    if (cat == 'diamond') themeColor = Colors.cyanAccent;
    if (cat == 'tebok') themeColor = Colors.purpleAccent;
    if (cat == 'bijian') themeColor = Colors.greenAccent;
    if (cat == 'BP') themeColor = Colors.pinkAccent;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _glassDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button
          InkWell(
            onTap: () => setState(() => _selectedCage = null),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_ios_rounded, color: Colors.cyanAccent, size: 14),
                const SizedBox(width: 6),
                const Text('Kembali ke Daftar Kerangka', style: TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Main Layout Detail
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Large wireframe blueprint
              Expanded(
                child: Container(
                  height: 380,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF060D1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: themeColor.withValues(alpha: 0.3)),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: CustomPaint(
                          size: const Size(double.infinity, double.infinity),
                          painter: BirdcageFramePainter(shape: c.bentuk, color: themeColor),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('SKETSA BLUEPRINT KERANGKA', style: TextStyle(fontSize: 9, color: Colors.white30, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('Bentuk: ${c.bentuk}', style: TextStyle(fontSize: 10, color: themeColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),

              // Right side: Info panel & details table
              SizedBox(
                width: 420,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(c.nama, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: themeColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: themeColor, width: 0.5),
                          ),
                          child: Text(cat.toUpperCase(), style: TextStyle(fontSize: 9, color: themeColor, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Ukuran Kerangka Fisik: ${c.ukuranTotal}', style: const TextStyle(fontSize: 11, color: Colors.white70)),
                    const SizedBox(height: 20),

                    // Components Title
                    const Text('Komponen Cetak & Kerangka Bagian', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 12),

                    // Table inside a container
                    Container(
                      constraints: const BoxConstraints(maxHeight: 240),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1.6), // Komponen
                            1: FlexColumnWidth(1.2), // Bentuk
                            2: FlexColumnWidth(1.6), // Ukuran
                          },
                          border: const TableBorder(horizontalInside: BorderSide(color: Colors.white10, width: 0.5)),
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(color: const Color(0xFF101B2D)),
                              children: [
                                _buildHeaderCell('Nama Bagian'),
                                _buildHeaderCell('Bentuk Area'),
                                _buildHeaderCell('Ukuran Kerangka'),
                              ],
                            ),
                            ...c.bagian.map((b) {
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(b.nama, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(b.bentukArea, style: const TextStyle(color: Colors.cyanAccent, fontSize: 10)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(b.ukuran, style: const TextStyle(color: Colors.white60, fontSize: 10)),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  void _tampilkanDialogSangkarBaru(BuildContext context) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: CreateCageDialog(
          onSave: (newJenisSangkar) {
            _controller.addCage(newJenisSangkar);

            // Auto create a draft template associated with this new cage
            final newTemplate = TemplateSangkar(
              id: 'TMP-${DateTime.now().millisecondsSinceEpoch}',
              nama: '${newJenisSangkar.nama} [Kerangka]',
              jenisSangkarId: newJenisSangkar.id,
              desainDecalIds: ['DSN-001'],
              thumbnail: 'assets/thumb/tmp001.png',
              popularitas: 70,
              status: 'Draft',
              dimensi: newJenisSangkar.ukuranTotal,
              layers: newJenisSangkar.bagian.length * 2,
              kategori: _getCageCategory(newJenisSangkar),
              komponen: {'Frame': 1, 'Ornamen': newJenisSangkar.bagian.length, 'Background': 1},
            );
            _controller.addTemplate(newTemplate);

            Get.back();
            Get.snackbar(
              'SUKSES',
              'Kerangka sangkar ${newJenisSangkar.nama} berhasil dicatat',
              backgroundColor: const Color(0xFF101B2D),
              colorText: Colors.cyanAccent,
              snackPosition: SnackPosition.BOTTOM,
            );
          },
        ),
      ),
    );
  }

  Widget _buildLeftMenuSection(String header, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: _glassDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(header, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54)),
          ),
          const SizedBox(height: 4),
          ...children,
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String title, int count, IconData icon) {
    final isSelected = _selectedCategory == title;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: isSelected ? Colors.cyanAccent.withValues(alpha: 0.08) : Colors.transparent,
        child: Row(
          children: [
            Icon(icon, size: 14, color: isSelected ? Colors.cyanAccent : Colors.white60),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected ? Colors.cyanAccent : Colors.white70,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Colors.cyanAccent : Colors.white30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _glassDecoration() {
    return BoxDecoration(
      color: const Color(0xFF091121),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
    );
  }
}

class CreateCageDialog extends StatefulWidget {
  final Function(JenisSangkar) onSave;
  const CreateCageDialog({super.key, required this.onSave});

  @override
  State<CreateCageDialog> createState() => _CreateCageDialogState();
}

class _CreateCageDialogState extends State<CreateCageDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  String _selectedCategory = 'kosan';

  final List<Map<String, dynamic>> _rows = [
    {'utama': 'Depan', 'komponen': 'raen atas', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '30 × 5 cm', 'kode': 'DEP-RA'},
    {'utama': 'Depan', 'komponen': 'raen bawah', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '30 × 8 cm', 'kode': 'DEP-RB'},
    {'utama': 'Depan', 'komponen': 'pintu atas', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '10 × 12 cm', 'kode': 'DEP-PA'},
    {'utama': 'Depan', 'komponen': 'pintu bawah', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '10 × 8 cm', 'kode': 'DEP-PB'},
    {'utama': 'Depan', 'komponen': 'tutup pintu', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '12 × 3 cm', 'kode': 'DEP-TP'},
    {'utama': 'Kiri', 'komponen': 'raen lengkung', 'aktif': true, 'bentuk': 'Lengkung', 'ukuran': '25 × 10 cm', 'kode': 'KIR-RL'},
    {'utama': 'Kiri', 'komponen': 'raen atas', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '25 × 5 cm', 'kode': 'KIR-RA'},
    {'utama': 'Kiri', 'komponen': 'raen bawah', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '25 × 8 cm', 'kode': 'KIR-RB'},
    {'utama': 'Kanan', 'komponen': 'raen lengkung', 'aktif': true, 'bentuk': 'Lengkung', 'ukuran': '25 × 10 cm', 'kode': 'KAN-RL'},
    {'utama': 'Kanan', 'komponen': 'raen atas', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '25 × 5 cm', 'kode': 'KAN-RA'},
    {'utama': 'Kanan', 'komponen': 'raen bawah', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '25 × 8 cm', 'kode': 'KAN-RB'},
    {'utama': 'Belakang', 'komponen': 'raen atas', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '30 × 5 cm', 'kode': 'BEL-RA'},
    {'utama': 'Belakang', 'komponen': 'raen bawah', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '30 × 8 cm', 'kode': 'BEL-RB'},
    {'utama': 'Atas', 'komponen': 'cantolan', 'aktif': true, 'bentuk': 'Silinder', 'ukuran': 'T 15 cm × Ø 8 cm', 'kode': 'ATS-CN'},
    {'utama': 'Bawah', 'komponen': 'kaki kaki', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '4 sisi × 5 × 5 cm', 'kode': 'BAW-KK'},
    {'utama': 'Bawah', 'komponen': 'alas', 'aktif': true, 'bentuk': 'Datar', 'ukuran': '30 × 30 cm', 'kode': 'BAW-AL'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800, maxHeight: 650),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0A19),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyanAccent, width: 0.5),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'BUAT KERANGKA SANGKAR BARU',
                  style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white60, size: 18),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Nama Kerangka', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _namaController,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                                decoration: InputDecoration(
                                  hintText: 'Masukkan nama kerangka...',
                                  hintStyle: const TextStyle(color: Colors.white30),
                                  filled: true,
                                  fillColor: const Color(0xFF101B2D),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.cyanAccent, width: 0.5)),
                                ),
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) return 'Nama tidak boleh kosong';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Kategori', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF101B2D),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedCategory,
                                    dropdownColor: const Color(0xFF0C0A19),
                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                    items: ['kosan', 'diamond', 'tebok', 'bijian', 'BP'].map((cat) {
                                      return DropdownMenuItem(value: cat, child: Text(cat));
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _selectedCategory = val;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tabel Konfigurasi Komponen Fisik',
                      style: TextStyle(color: Colors.cyanAccent, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Aktifkan komponen yang sesuai dengan tipe sangkar ini, lalu tentukan bentuk dan ukurannya.',
                      style: TextStyle(color: Colors.white30, fontSize: 9),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1.2),
                          1: FlexColumnWidth(1.5),
                          2: FlexColumnWidth(0.8),
                          3: FlexColumnWidth(1.5),
                          4: FlexColumnWidth(2.0),
                        },
                        border: const TableBorder(
                          horizontalInside: BorderSide(color: Colors.white10, width: 0.5),
                        ),
                        children: [
                          TableRow(
                            decoration: const BoxDecoration(color: const Color(0xFF101B2D)),
                            children: [
                              _buildTableHeaderCell('Bagian'),
                              _buildTableHeaderCell('Komponen'),
                              _buildTableHeaderCell('Aktif'),
                              _buildTableHeaderCell('Bentuk'),
                              _buildTableHeaderCell('Ukuran'),
                            ],
                          ),
                          ..._rows.map((row) {
                            final idx = _rows.indexOf(row);
                            final bool isActive = row['aktif'] as bool;
                            return TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Text(row['utama'] as String, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  child: Text(row['komponen'] as String, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  child: Switch(
                                    value: isActive,
                                    activeThumbColor: Colors.cyanAccent,
                                    onChanged: (val) {
                                      setState(() {
                                        _rows[idx]['aktif'] = val;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  child: Opacity(
                                    opacity: isActive ? 1.0 : 0.4,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: row['bentuk'] as String,
                                        disabledHint: Text(row['bentuk'] as String, style: const TextStyle(color: Colors.white24)),
                                        dropdownColor: const Color(0xFF0C0A19),
                                        style: const TextStyle(color: Colors.cyanAccent, fontSize: 11),
                                        items: ['Datar', 'Lengkung', 'Silinder', 'Segitiga'].map((shape) {
                                          return DropdownMenuItem(value: shape, child: Text(shape));
                                        }).toList(),
                                        onChanged: isActive
                                            ? (val) {
                                                if (val != null) {
                                                  setState(() {
                                                    _rows[idx]['bentuk'] = val;
                                                  });
                                                }
                                              }
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  child: Opacity(
                                    opacity: isActive ? 1.0 : 0.4,
                                    child: TextFormField(
                                      initialValue: row['ukuran'] as String,
                                      enabled: isActive,
                                      style: const TextStyle(color: Colors.white, fontSize: 11),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                        border: InputBorder.none,
                                        hintText: 'misal: 30 × 5 cm',
                                        hintStyle: TextStyle(color: Colors.white24),
                                      ),
                                      onChanged: (val) {
                                        _rows[idx]['ukuran'] = val;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Batal', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Simpan Kerangka', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final String name = _namaController.text.trim();
    final String sangkarId = 'SK-${DateTime.now().millisecondsSinceEpoch}';

    final List<BagianSangkar> parts = [];
    for (var r in _rows) {
      if (r['aktif'] as bool) {
        parts.add(BagianSangkar(
          kode: r['kode'] as String,
          nama: '${r['utama']}: ${r['komponen']}',
          ukuran: r['ukuran'] as String,
          bentukArea: r['bentuk'] as String,
          perluDecal: true,
        ));
      }
    }

    if (parts.isEmpty) {
      Get.snackbar(
        'PERINGATAN',
        'Aktifkan minimal satu komponen!',
        backgroundColor: const Color(0xFF0C0A19),
        colorText: Colors.orangeAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    String bentuk = 'Kotak';
    if (_selectedCategory == 'tebok' || _selectedCategory == 'BP') {
      bentuk = 'Bulat';
    } else if (_selectedCategory == 'diamond') {
      bentuk = 'Hexagon';
    }

    final newJenisSangkar = JenisSangkar(
      id: sangkarId,
      nama: name,
      bentuk: bentuk,
      jenisBurung: _selectedCategory == 'tebok' ? 'Murai' : 'Kacer/Kenari',
      ukuranTotal: parts.isNotEmpty ? parts.last.ukuran : 'Standar',
      bagian: parts,
    );

    widget.onSave(newJenisSangkar);
  }
}
