import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup01/models/sangkar_models.dart';
import 'package:mocupsangkar/features/mockup01/features/pesanan/pesanan_form_page.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  String _searchQuery = '';
  String _selectedCategory = 'Semua Kategori';
  String _statusFilter = 'Semua';
  bool _isGridView = true;

  // Track if we are viewing the dedicated detail page
  TemplateSangkar? _viewingDetailTemplate;

  // Active tab in the detail page
  String _activeDetailTab = 'Komponen';

  @override
  Widget build(BuildContext context) {
    // If a template is selected for detail view, render the dedicated Detail Page
    if (_viewingDetailTemplate != null) {
      return _buildDedicatedDetailPage(_viewingDetailTemplate!);
    }

    // Otherwise, render the main Template Dashboard/Grid
    final listTemplate = DummyDb.template;

    // Calculate stats dynamically
    final totalCount = listTemplate.length;
    final draftCount = listTemplate.where((t) => t.status == 'Draft').length;
    final activeCount = listTemplate.where((t) => t.status == 'Aktif').length;
    final mostUsed = listTemplate.first; // Premium Lengkung 50
    final lastCreated = listTemplate.firstWhere((t) => t.nama.contains('Minimalis'), orElse: () => listTemplate.first);

    // Filter templates
    final filteredTemplates = listTemplate.where((t) {
      final matchSearch = t.nama.toLowerCase().contains(_searchQuery);
      final matchCategory = _selectedCategory == 'Semua Kategori' || t.kategori == _selectedCategory;
      final matchStatus = _statusFilter == 'Semua' || t.status == _statusFilter;
      return matchSearch && matchCategory && matchStatus;
    }).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // TOP HEADER ROW
          // ==========================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Template',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Buat, kelola dan gunakan template desain sangkar',
                    style: TextStyle(fontSize: 10, color: Colors.cyanAccent),
                  ),
                ],
              ),
              // Right Search + Actions
              Row(
                children: [
                  // Search Input
                  SizedBox(
                    width: 200,
                    height: 36,
                    child: TextField(
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Cari template...',
                        hintStyle: const TextStyle(color: Colors.white30, fontSize: 11),
                        prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent, size: 14),
                        filled: true,
                        fillColor: const Color(0xFF101B2D),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.cyan.withValues(alpha: 0.15)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.cyanAccent),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val.toLowerCase();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Filter Dropdown
                  Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF101B2D),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: const Color(0xFF101B2D),
                        value: _statusFilter,
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.cyanAccent, size: 16),
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                        items: ['Semua', 'Aktif', 'Draft'].map((s) {
                          return DropdownMenuItem(value: s, child: Text(s));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _statusFilter = val);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // New Template Button
                  ElevatedButton.icon(
                    onPressed: () => _tampilkanDialogTemplateBaru(context),
                    icon: const Icon(Icons.add, size: 14, color: Colors.black),
                    label: const Text('Template Baru', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ==========================================
          // STATS ROW (5 Cards)
          // ==========================================
          Row(
            children: [
              _buildMiniStatCard('Total Template', '$totalCount', 'Template tersimpan', Icons.inventory_2_outlined, Colors.purpleAccent),
              const SizedBox(width: 12),
              _buildMiniStatCard('Draft', '$draftCount', 'Belum dipublish', Icons.edit_document, Colors.orangeAccent),
              const SizedBox(width: 12),
              _buildMiniStatCard('Publik', '$activeCount', 'Siap digunakan', Icons.public, Colors.greenAccent),
              const SizedBox(width: 12),
              _buildMiniStatCard('Paling Digunakan', mostUsed.nama.split(' ').first, 'Digunakan 342x', Icons.star_border, Colors.amberAccent),
              const SizedBox(width: 12),
              _buildMiniStatCard('Terakhir Dibuat', lastCreated.nama.split(' ').first, lastCreated.tanggalDibuat, Icons.update, Colors.cyanAccent),
            ],
          ),
          const SizedBox(height: 20),

          // ==========================================
          // MAIN PANEL (Kategori Sidebar + Grid List)
          // ==========================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Kategori & Tags & Aksi Cepat
              SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeftMenuSection('Kategori', [
                      _buildCategoryRow('Semua Kategori', totalCount, Icons.grid_view_rounded),
                      _buildCategoryRow('Premium', 38, Icons.workspace_premium_outlined),
                      _buildCategoryRow('Minimalis', 24, Icons.square_foot_outlined),
                      _buildCategoryRow('Classic', 18, Icons.auto_awesome_outlined),
                      _buildCategoryRow('Lengkung', 22, Icons.circle_outlined),
                      _buildCategoryRow('Kotak', 16, Icons.check_box_outline_blank_rounded),
                    ]),
                    const SizedBox(height: 16),
                    _buildLeftTagSection('Tag Populer', [
                      'Premium', 'Lengkung', 'Elegan',
                      'Minimalis', 'Kotak', 'Modern',
                      'Gold', 'Classic'
                    ]),
                    const SizedBox(height: 16),
                    _buildLeftActionSection('Aksi Cepat'),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Center Column: Template Grid (Larger width now, fits 3 columns!)
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 485), // Align height with left column safely
                  padding: const EdgeInsets.all(16),
                  decoration: _glassDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Semua Template',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          // View Switcher
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => setState(() => _isGridView = true),
                                icon: Icon(Icons.grid_on_rounded, size: 16, color: _isGridView ? Colors.cyanAccent : Colors.white30),
                              ),
                              IconButton(
                                onPressed: () => setState(() => _isGridView = false),
                                icon: Icon(Icons.list_alt_rounded, size: 16, color: !_isGridView ? Colors.cyanAccent : Colors.white30),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      filteredTemplates.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 40),
                                child: Text('Tidak ada template cocok.', style: TextStyle(color: Colors.white38, fontSize: 12)),
                              ),
                            )
                          : _isGridView
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: filteredTemplates.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // Changed from 2 to 3 columns to fit nicely!
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.95,
                                  ),
                                  itemBuilder: (context, idx) {
                                    final t = filteredTemplates[idx];
                                    return _buildGridCard(t);
                                  },
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: filteredTemplates.length,
                                  separatorBuilder: (context, index) => const Divider(color: Colors.white10),
                                  itemBuilder: (context, idx) {
                                    final t = filteredTemplates[idx];
                                    return _buildListRow(t);
                                  },
                                ),
                      const SizedBox(height: 20),
                      // Pagination
                      _buildPagination(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ==========================================
          // BOTTOM ROW: Template yang Sering Digunakan
          // ==========================================
          const Text(
            'Template yang Sering Digunakan',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: listTemplate.take(5).length,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, idx) {
                      final t = listTemplate[idx];
                      return _buildHorizontalRecommendCard(t);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Promo Card
              Container(
                width: 260,
                height: 120,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0D1E3A), Color(0xFF051020)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Butuh Inspirasi?', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 4),
                          const Text(
                            'Jelajahi blueprint atau template komunitas untuk memulai desain Anda.',
                            style: TextStyle(fontSize: 9, color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF101B2D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                                side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('Jelajahi Blueprint', style: TextStyle(color: Colors.cyanAccent, fontSize: 8, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Small visual representation of 3D layered lines
                    CustomPaint(
                      size: const Size(60, 60),
                      painter: _IsometricLayerPainter(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ==========================================
  // DEDICATED DETAIL PAGE (Workflow / Navigasi)
  // ==========================================
  Widget _buildDedicatedDetailPage(TemplateSangkar t) {
    final isAktif = t.status == 'Aktif';
    final sangkar = DummyDb.jenisSangkar.firstWhere((s) => s.id == t.jenisSangkarId, orElse: () => DummyDb.jenisSangkar.first);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _glassDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Back button & Top Navigation
          InkWell(
            onTap: () {
              setState(() {
                _viewingDetailTemplate = null; // Go back to dashboard grid
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_ios_rounded, color: Colors.cyanAccent, size: 14),
                const SizedBox(width: 6),
                const Text(
                  'Kembali',
                  style: TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. Main Detail Section (Row of Preview & Right Info panel)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Large Frame Preview
              Expanded(
                child: Container(
                  height: 380,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF060D1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: CustomPaint(
                          size: const Size(double.infinity, double.infinity),
                          painter: BirdcageFramePainter(shape: sangkar.bentuk, color: Colors.cyanAccent),
                        ),
                      ),
                      // Height dimensions marker line
                      Positioned(
                        right: 15,
                        top: 40,
                        bottom: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: 1, height: 120, color: Colors.cyanAccent.withValues(alpha: 0.3)),
                            const SizedBox(height: 6),
                            Text(
                              t.dimensi.split('x').last.trim(),
                              style: const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Container(width: 1, height: 120, color: Colors.cyanAccent.withValues(alpha: 0.3)),
                          ],
                        ),
                      ),
                      // Width dimensions marker line
                      Positioned(
                        bottom: 15,
                        left: 40,
                        right: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: 70, height: 1, color: Colors.cyanAccent.withValues(alpha: 0.3)),
                            const SizedBox(width: 8),
                            Text(
                              t.dimensi.split('x').first.trim(),
                              style: const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Container(width: 70, height: 1, color: Colors.cyanAccent.withValues(alpha: 0.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),

              // Right side: Name, Status, Action row & Informasi
              SizedBox(
                width: 360,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header title & badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            t.nama,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isAktif ? Colors.green.withValues(alpha: 0.15) : Colors.orange.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: isAktif ? Colors.greenAccent : Colors.orangeAccent, width: 0.5),
                          ),
                          child: Text(
                            t.status.toUpperCase(),
                            style: TextStyle(fontSize: 9, color: isAktif ? Colors.greenAccent : Colors.orangeAccent, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildCategoryPill(t.kategori),
                        const SizedBox(width: 6),
                        const Text('Tampilan', style: TextStyle(fontSize: 10, color: Colors.white38)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Actions Row 1 (Edit, Tampilan)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit, size: 14),
                            label: const Text('Edit', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF101B2D),
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white10),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.palette_outlined, size: 14, color: Colors.greenAccent),
                            label: const Text('Tampilan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF101B2D),
                              foregroundColor: Colors.greenAccent,
                              side: BorderSide(color: Colors.greenAccent.withValues(alpha: 0.3)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Actions Row 2 (Duplicate, Export, Hapus)
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailActionButton(Icons.copy, 'Duplicate', () {}),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildDetailActionButton(Icons.ios_share_outlined, 'Export', () {}),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildDetailActionButton(Icons.delete_outline, 'Hapus', () {}, isRed: true),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Informasi List
                    const Text('Informasi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 10),
                    _buildInfoRow('Kategori', t.kategori),
                    _buildInfoRow('Jenis Bentuk', sangkar.bentuk),
                    _buildInfoRow('Ukuran', t.dimensi),
                    _buildInfoRow('Layer', '${t.layers} Layer'),
                    _buildInfoRow('Versi', t.versi),
                    _buildInfoRow('Dibuat', t.tanggalDibuat),
                    _buildInfoRow('Diperbarui', t.tanggalDibuat), // Simulating updated date
                    _buildInfoRow('Dibuat oleh', t.dibuatOleh),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 3. Bottom Tab Menu: Komponen, Preview, Riwayat Versi, Penggunaan
          Row(
            children: ['Komponen', 'Preview', 'Riwayat Versi', 'Penggunaan'].map((tab) {
              final isTabSelected = _activeDetailTab == tab;
              return InkWell(
                onTap: () => setState(() => _activeDetailTab = tab),
                child: Container(
                  margin: const EdgeInsets.only(right: 24),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isTabSelected ? Colors.cyanAccent : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isTabSelected ? FontWeight.bold : FontWeight.normal,
                      color: isTabSelected ? Colors.cyanAccent : Colors.white60,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 16),

          // 4. Tab Contents
          _activeDetailTab == 'Komponen'
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Komponen Template List
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101B2D),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Komponen Template', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                            const SizedBox(height: 12),
                            _buildComponentRow('Frame', 1),
                            _buildComponentRow('Ornamen', t.layers ~/ 2),
                            _buildComponentRow('Area Foto', 1),
                            _buildComponentRow('Area Teks', 4),
                            _buildComponentRow('Background', 1),
                            _buildComponentRow('Logo', 1),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Right Column: Thumbnail Preview Box
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101B2D),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Thumbnail', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit_outlined, size: 14, color: Colors.cyanAccent),
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color(0xFF091121),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                    minimumSize: Size.zero,
                                    padding: const EdgeInsets.all(6),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Large preview box in thumbnail style
                            Container(
                              height: 120,
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF060D1A),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CustomPaint(
                                painter: BirdcageFramePainter(shape: sangkar.bentuk, color: Colors.cyanAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Riwayat & data $_activeDetailTab akan ditampilkan di sini.',
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                ),
          const SizedBox(height: 20),

          // Bottom Action to Create Order
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  () => PesananFormPage(template: t),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 300),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Gunakan Template', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // METRICS & LAYOUT ROW BUILDERS
  // ==========================================

  Widget _buildMiniStatCard(String title, String value, String desc, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: _glassDecoration(),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 9, color: Colors.white38)),
                  const SizedBox(height: 2),
                  Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 1),
                  Text(desc, style: const TextStyle(fontSize: 8, color: Colors.white54), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftMenuSection(String header, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
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

  Widget _buildLeftTagSection(String header, List<String> tags) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _glassDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF101B2D),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white10),
                ),
                child: Text(tag, style: const TextStyle(fontSize: 9, color: Colors.white70)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftActionSection(String header) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _glassDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54)),
          const SizedBox(height: 8),
          _buildActionItem(Icons.add, 'Template Baru', () => _tampilkanDialogTemplateBaru(context)),
          _buildActionItem(Icons.file_download_outlined, 'Import Template', () {}),
          _buildActionItem(Icons.grid_goldenratio_outlined, 'Pilih dari Blueprint', () {}),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 14, color: Colors.cyanAccent),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCard(TemplateSangkar t) {
    final sangkar = DummyDb.jenisSangkar.firstWhere((s) => s.id == t.jenisSangkarId, orElse: () => DummyDb.jenisSangkar.first);

    return InkWell(
      onTap: () {
        setState(() {
          _viewingDetailTemplate = t; // Switch to the dedicated Detail view!
          _activeDetailTab = 'Komponen'; // Reset active tab
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF101B2D),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wireframe Preview Canvas
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF060D1A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomPaint(
                  painter: BirdcageFramePainter(
                    shape: sangkar.bentuk,
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryPill(t.kategori),
                Text('${t.popularitas}% Populer', style: const TextStyle(fontSize: 8, color: Colors.amber)),
              ],
            ),
            const SizedBox(height: 4),
            Text(t.nama, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text('${t.dimensi} • ${t.layers} Layer', style: const TextStyle(fontSize: 9, color: Colors.white54)),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dipakai 128x', style: const TextStyle(fontSize: 8, color: Colors.white30)),
                Text(t.harga, style: const TextStyle(fontSize: 10, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListRow(TemplateSangkar t) {
    final sangkar = DummyDb.jenisSangkar.firstWhere((s) => s.id == t.jenisSangkarId, orElse: () => DummyDb.jenisSangkar.first);

    return InkWell(
      onTap: () {
        setState(() {
          _viewingDetailTemplate = t; // Switch to the dedicated Detail view!
          _activeDetailTab = 'Komponen'; // Reset active tab
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF060D1A),
                borderRadius: BorderRadius.circular(6),
              ),
              child: CustomPaint(
                painter: BirdcageFramePainter(shape: sangkar.bentuk, color: Colors.cyanAccent),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.nama, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('${t.dimensi} · ${t.layers} Layer', style: const TextStyle(fontSize: 9, color: Colors.white54)),
                ],
              ),
            ),
            _buildCategoryPill(t.kategori),
            const SizedBox(width: 12),
            Text(t.harga, style: const TextStyle(fontSize: 11, color: Colors.greenAccent, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPill(String cat) {
    Color badgeColor;
    switch (cat) {
      case 'Premium':
        badgeColor = Colors.orange;
        break;
      case 'Minimalis':
        badgeColor = Colors.blue;
        break;
      case 'Classic':
        badgeColor = Colors.purpleAccent;
        break;
      case 'Lengkung':
        badgeColor = Colors.cyan;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Text(
        cat.toUpperCase(),
        style: TextStyle(fontSize: 7, color: badgeColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailActionButton(IconData icon, String label, VoidCallback onTap, {bool isRed = false}) {
    final color = isRed ? Colors.redAccent : Colors.white70;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF101B2D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isRed ? Colors.redAccent.withValues(alpha: 0.2) : Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.white38)),
          Text(value, style: const TextStyle(fontSize: 11, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildComponentRow(String compName, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.layers_outlined, size: 12, color: Colors.cyanAccent),
              const SizedBox(width: 8),
              Text(compName, style: const TextStyle(fontSize: 11, color: Colors.white70)),
            ],
          ),
          Text('$count', style: const TextStyle(fontSize: 11, color: Colors.white70, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPaginationButton('«'),
        _buildPaginationButton('<'),
        _buildPaginationButton('1', isSelected: true),
        _buildPaginationButton('2'),
        _buildPaginationButton('3'),
        _buildPaginationButton('...'),
        _buildPaginationButton('16'),
        _buildPaginationButton('>'),
        _buildPaginationButton('»'),
      ],
    );
  }

  Widget _buildPaginationButton(String val, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.cyanAccent : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        val,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.black : Colors.white60,
        ),
      ),
    );
  }

  Widget _buildHorizontalRecommendCard(TemplateSangkar t) {
    final sangkar = DummyDb.jenisSangkar.firstWhere((s) => s.id == t.jenisSangkarId, orElse: () => DummyDb.jenisSangkar.first);

    return Container(
      width: 220,
      padding: const EdgeInsets.all(10),
      decoration: _glassDecoration(),
      child: Row(
        children: [
          Container(
            width: 44,
            height: double.infinity,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF060D1A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomPaint(
              painter: BirdcageFramePainter(shape: sangkar.bentuk, color: Colors.cyanAccent),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(t.nama, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                _buildCategoryPill(t.kategori),
                const SizedBox(height: 4),
                Text('Digunakan ${t.popularitas * 3}x', style: const TextStyle(fontSize: 8, color: Colors.white38)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _viewingDetailTemplate = t; // Switch to the dedicated Detail view!
                _activeDetailTab = 'Komponen'; // Reset active tab
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Gunakan', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _tampilkanDialogTemplateBaru(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0C0A19),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
        ),
        title: const Text('BUAT TEMPLATE BARU', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Gunakan Blueprint Editor or Custom Canvas untuk merancang template baru.',
              style: TextStyle(color: Colors.white70, fontSize: 11),
            ),
            const SizedBox(height: 12),
            _buildDialogButton('Mulai dari Blueprint', () => Get.back()),
            const SizedBox(height: 8),
            _buildDialogButton('Unggah File CAD/Vector', () => Get.back(), isSecondary: true),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogButton(String label, VoidCallback onTap, {bool isSecondary = false}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? const Color(0xFF101B2D) : Colors.cyanAccent,
          foregroundColor: isSecondary ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isSecondary ? const BorderSide(color: Colors.white10) : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
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

// ===========================================================
// VECTOR FRAME PAINTER (Domes, Boxes, Ovals, Hexagons)
// ===========================================================
class BirdcageFramePainter extends CustomPainter {
  final String shape;
  final Color color;

  BirdcageFramePainter({required this.shape, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.03)
      ..style = PaintingStyle.fill;

    final path = Path();
    final double w = size.width;
    final double h = size.height;

    if (shape == 'Lengkung' || shape == 'Bulat') {
      // Top hanger
      canvas.drawCircle(Offset(w / 2, h * 0.1), 4, paint);
      canvas.drawLine(Offset(w / 2, h * 0.1), Offset(w / 2, h * 0.2), paint);

      // Outer shape dome
      path.moveTo(w / 2, h * 0.2);
      path.quadraticBezierTo(w * 0.1, h * 0.25, w * 0.1, h * 0.5);
      path.lineTo(w * 0.1, h * 0.85);
      path.lineTo(w * 0.9, h * 0.85);
      path.lineTo(w * 0.9, h * 0.5);
      path.quadraticBezierTo(w * 0.9, h * 0.25, w / 2, h * 0.2);
      
      // Bottom tray
      canvas.drawRect(Rect.fromLTRB(w * 0.05, h * 0.85, w * 0.95, h * 0.92), paint);
      canvas.drawRect(Rect.fromLTRB(w * 0.05, h * 0.85, w * 0.95, h * 0.92), fillPaint);
      
      // Vertical cage bars
      for (double i = 0.2; i <= 0.8; i += 0.15) {
        canvas.drawLine(Offset(w * i, h * 0.4), Offset(w * i, h * 0.85), paint..strokeWidth = 0.4);
      }
    } else if (shape == 'Oval') {
      canvas.drawCircle(Offset(w / 2, h * 0.1), 4, paint);
      canvas.drawLine(Offset(w / 2, h * 0.1), Offset(w / 2, h * 0.2), paint);

      path.moveTo(w / 2, h * 0.2);
      path.quadraticBezierTo(w * 0.12, h * 0.25, w * 0.12, h * 0.5);
      path.quadraticBezierTo(w * 0.12, h * 0.78, w / 2, h * 0.85);
      path.quadraticBezierTo(w * 0.88, h * 0.78, w * 0.88, h * 0.5);
      path.quadraticBezierTo(w * 0.88, h * 0.25, w / 2, h * 0.2);

      canvas.drawRect(Rect.fromLTRB(w * 0.12, h * 0.85, w * 0.88, h * 0.92), paint);
      canvas.drawRect(Rect.fromLTRB(w * 0.12, h * 0.85, w * 0.88, h * 0.92), fillPaint);

      for (double i = 0.25; i <= 0.75; i += 0.12) {
        canvas.drawLine(Offset(w * i, h * 0.35), Offset(w * i, h * 0.8), paint..strokeWidth = 0.4);
      }
    } else if (shape == 'Hexagon') {
      canvas.drawCircle(Offset(w / 2, h * 0.1), 4, paint);
      canvas.drawLine(Offset(w / 2, h * 0.1), Offset(w / 2, h * 0.2), paint);

      path.moveTo(w / 2, h * 0.2);
      path.lineTo(w * 0.2, h * 0.35);
      path.lineTo(w * 0.2, h * 0.85);
      path.lineTo(w * 0.8, h * 0.85);
      path.lineTo(w * 0.8, h * 0.35);
      path.close();

      canvas.drawRect(Rect.fromLTRB(w * 0.1, h * 0.85, w * 0.9, h * 0.92), paint);
      canvas.drawRect(Rect.fromLTRB(w * 0.1, h * 0.85, w * 0.9, h * 0.92), fillPaint);

      for (double i = 0.3; i <= 0.7; i += 0.2) {
        canvas.drawLine(Offset(w * i, h * 0.35), Offset(w * i, h * 0.85), paint..strokeWidth = 0.4);
      }
    } else {
      // Default: Kotak / Rectangular Box
      canvas.drawCircle(Offset(w / 2, h * 0.1), 4, paint);
      canvas.drawLine(Offset(w / 2, h * 0.1), Offset(w / 2, h * 0.2), paint);

      path.moveTo(w * 0.2, h * 0.2);
      path.lineTo(w * 0.8, h * 0.2);
      path.lineTo(w * 0.8, h * 0.85);
      path.lineTo(w * 0.2, h * 0.85);
      path.close();

      canvas.drawRect(Rect.fromLTRB(w * 0.15, h * 0.85, w * 0.85, h * 0.92), paint);
      canvas.drawRect(Rect.fromLTRB(w * 0.15, h * 0.85, w * 0.85, h * 0.92), fillPaint);

      for (double i = 0.3; i <= 0.7; i += 0.1) {
        canvas.drawLine(Offset(w * i, h * 0.2), Offset(w * i, h * 0.85), paint..strokeWidth = 0.4);
      }
    }

    canvas.drawPath(path, paint..strokeWidth = 1.0);
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Draw simple isometric layers in promo card
class _IsometricLayerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyanAccent.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final fillPaint = Paint()
      ..color = Colors.cyan.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    // Draw three offset parallelograms representing layers
    for (double dy = 0; dy <= 20; dy += 10) {
      final path = Path()
        ..moveTo(25, 10 + dy)
        ..lineTo(55, 20 + dy)
        ..lineTo(35, 35 + dy)
        ..lineTo(5, 25 + dy)
        ..close();
      canvas.drawPath(path, fillPaint);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
