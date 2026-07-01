import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:mocupsangkar/features/mockup01/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup01/models/sangkar_models.dart';
import 'package:mocupsangkar/features/mockup01/features/pesanan/pesanan_form_page.dart';
import 'package:mocupsangkar/features/mockup01/controllers/sangkar_controller.dart';

class TemplatePage extends StatefulWidget {
  final Color accentColor;
  final Color cardColor;
  final Color backgroundColor;
  final bool isLightTheme;

  const TemplatePage({
    super.key,
    this.accentColor = Colors.cyanAccent,
    this.cardColor = const Color(0xFF101B2D),
    this.backgroundColor = const Color(0xFF0C0A19),
    this.isLightTheme = false,
  });

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  final SangkarController _sangkarController = Get.find<SangkarController>();

  String _searchQuery = '';
  String _selectedCategory = 'Semua Kategori';
  String _statusFilter = 'Semua';
  bool _isGridView = true;

  // Track if we are viewing the dedicated detail page
  TemplateSangkar? _viewingDetailTemplate;

  // Active tab in the detail page
  String _activeDetailTab = 'Bagian Sangkar';
  bool _showDecalPattern = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final listTemplate = _sangkarController.templates;

      // If a template is selected for detail view, render the dedicated Detail Page
      if (_viewingDetailTemplate != null) {
        final freshT = listTemplate.firstWhere(
          (t) => t.id == _viewingDetailTemplate!.id,
          orElse: () => _viewingDetailTemplate!,
        );
        return _buildDedicatedDetailPage(freshT);
      }

      // Calculate stats dynamically
      final totalCount = listTemplate.length;
      final draftCount = listTemplate.where((t) => t.status == 'Draft').length;
      final activeCount = listTemplate.where((t) => t.status == 'Aktif').length;
      final mostUsed = listTemplate.isNotEmpty ? listTemplate.first : null;
      final lastCreated = listTemplate.isNotEmpty
          ? listTemplate.firstWhere((t) => t.kategori == 'kosan', orElse: () => listTemplate.first)
          : null;

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
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
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
              Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Search Input
                  SizedBox(
                    width: 180,
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
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              int cardsPerRow = 5;
              if (w < 600) {
                cardsPerRow = 2;
              } else if (w < 950) {
                cardsPerRow = 3;
              }
              
              final double spacing = 12;
              final double cardWidth = (w - (spacing * (cardsPerRow - 1))) / cardsPerRow;
              
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  _buildMiniStatCard('Total Template', '$totalCount', 'Template tersimpan', Icons.inventory_2_outlined, Colors.purpleAccent, width: cardWidth),
                  _buildMiniStatCard('Draft', '$draftCount', 'Belum dipublish', Icons.edit_document, Colors.orangeAccent, width: cardWidth),
                  _buildMiniStatCard('Publik', '$activeCount', 'Siap digunakan', Icons.public, Colors.greenAccent, width: cardWidth),
                  _buildMiniStatCard('Paling Digunakan', mostUsed != null ? mostUsed.nama.split(' ').first : '-', 'Belum ada data', Icons.star_border, Colors.amberAccent, width: cardWidth),
                  _buildMiniStatCard('Terakhir Dibuat', lastCreated != null ? lastCreated.nama.split(' ').first : '-', lastCreated != null ? lastCreated.tanggalDibuat : '-', Icons.update, Colors.cyanAccent, width: cardWidth),
                ],
              );
            },
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
                      _buildCategoryRow('kosan', listTemplate.where((t) => t.kategori == 'kosan').length, Icons.square_foot_outlined),
                      _buildCategoryRow('diamond', listTemplate.where((t) => t.kategori == 'diamond').length, Icons.auto_awesome_outlined),
                      _buildCategoryRow('tebok', listTemplate.where((t) => t.kategori == 'tebok').length, Icons.circle_outlined),
                      _buildCategoryRow('bijian', listTemplate.where((t) => t.kategori == 'bijian').length, Icons.grid_on_outlined),
                      _buildCategoryRow('BP', listTemplate.where((t) => t.kategori == 'BP').length, Icons.token_outlined),
                    ]),
                    const SizedBox(height: 16),
                    _buildLeftTagSection('Tag Populer', [
                      'kosan', 'diamond', 'tebok',
                      'bijian', 'BP', 'Murai',
                      'ceper', 'timbul'
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
                              ? LayoutBuilder(
                                  builder: (context, gridConstraints) {
                                    final gw = gridConstraints.maxWidth;
                                    int crossAxisCount = 3;
                                    double childAspectRatio = 0.80; // Taller card aspect ratio to accommodate content
                                    
                                    if (gw < 500) {
                                      crossAxisCount = 1;
                                      childAspectRatio = 1.15;
                                    } else if (gw < 780) {
                                      crossAxisCount = 2;
                                      childAspectRatio = 0.82;
                                    }
                                    
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: filteredTemplates.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                        childAspectRatio: childAspectRatio,
                                      ),
                                      itemBuilder: (context, idx) {
                                        final t = filteredTemplates[idx];
                                        return _buildGridCard(t);
                                      },
                                    );
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
    });
  }

  // ==========================================
  // DEDICATED DETAIL PAGE (Workflow / Navigasi)
  // ==========================================
  Widget _buildDedicatedDetailPage(TemplateSangkar t) {
    final isAktif = t.status == 'Aktif';
    final sangkar = _sangkarController.cages.firstWhere((s) => s.id == t.jenisSangkarId, orElse: () => _sangkarController.cages.first);

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
                            Expanded(child: Container(width: 1, color: Colors.cyanAccent.withValues(alpha: 0.3))),
                            const SizedBox(height: 6),
                            Text(
                              t.dimensi.split('x').last.trim(),
                              style: const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Expanded(child: Container(width: 1, color: Colors.cyanAccent.withValues(alpha: 0.3))),
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
                            Expanded(child: Container(height: 1, color: Colors.cyanAccent.withValues(alpha: 0.3))),
                            const SizedBox(width: 8),
                            Text(
                              t.dimensi.split('x').first.trim(),
                              style: const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Container(height: 1, color: Colors.cyanAccent.withValues(alpha: 0.3))),
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.dialog(
                                Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Interactive3DView(
                                    shape: sangkar.bentuk,
                                    title: t.nama,
                                    templateName: t.nama,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.view_in_ar_outlined, size: 14, color: Colors.cyanAccent),
                            label: const Text('Lihat 3D', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF101B2D),
                              foregroundColor: Colors.cyanAccent,
                              side: BorderSide(color: Colors.cyanAccent.withValues(alpha: 0.3)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.dialog(
                                Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: PdfPrintLayoutView(
                                    template: t,
                                    cage: sangkar,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.print_outlined, size: 14, color: Colors.amberAccent),
                            label: const Text('Cetak PDF', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amberAccent)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF101B2D),
                              foregroundColor: Colors.amberAccent,
                              side: BorderSide(color: Colors.amberAccent.withValues(alpha: 0.3)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
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

          // 3. Bottom Tab Menu: Bagian Sangkar, Komponen, Preview, Riwayat Versi, Penggunaan
          Row(
            children: ['Bagian Sangkar', 'Komponen', 'Preview', 'Riwayat Versi', 'Penggunaan'].map((tab) {
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
          _activeDetailTab == 'Bagian Sangkar'
              ? _buildBagianSangkarTab(t, sangkar)
              : _activeDetailTab == 'Komponen'
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

  Widget _buildMiniStatCard(String title, String value, String desc, IconData icon, Color color, {required double width}) {
    return Container(
      width: width,
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
                Text(title, style: const TextStyle(fontSize: 9, color: Colors.white38), overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.ellipsis),
                const SizedBox(height: 1),
                Text(desc, style: const TextStyle(fontSize: 8, color: Colors.white54), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
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
    final sangkar = _sangkarController.cages.firstWhere((s) => s.id == t.jenisSangkarId, orElse: () => _sangkarController.cages.first);

    return InkWell(
      onTap: () {
        setState(() {
          _viewingDetailTemplate = t; // Switch to the dedicated Detail view!
          _activeDetailTab = 'Bagian Sangkar'; // Reset active tab
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
                child: Stack(
                  children: [
                    Center(
                      child: CustomPaint(
                        size: const Size(double.infinity, double.infinity),
                        painter: BirdcageFramePainter(
                          shape: sangkar.bentuk,
                          color: Colors.white30,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Tooltip(
                        message: 'Pratinjau 3D',
                        child: InkWell(
                          onTap: () {
                            Get.dialog(
                              Dialog(
                                backgroundColor: Colors.transparent,
                                child: Interactive3DView(
                                  shape: sangkar.bentuk,
                                  title: t.nama,
                                  templateName: t.nama,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: const Color(0xFF101B2D),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.view_in_ar_outlined,
                              color: Colors.cyanAccent,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
            const SizedBox(height: 1),
            Text('Sangkar: ${sangkar.nama}', style: const TextStyle(fontSize: 9, color: Colors.cyanAccent), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text('${t.dimensi} • ${t.layers} Layer', style: const TextStyle(fontSize: 9, color: Colors.white54)),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dipakai 128x', style: const TextStyle(fontSize: 8, color: Colors.white30)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListRow(TemplateSangkar t) {
    final sangkar = _sangkarController.cages.firstWhere((s) => s.id == t.jenisSangkarId, orElse: () => _sangkarController.cages.first);

    return InkWell(
      onTap: () {
        setState(() {
          _viewingDetailTemplate = t; // Switch to the dedicated Detail view!
          _activeDetailTab = 'Bagian Sangkar'; // Reset active tab
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
                  Text('Sangkar: ${sangkar.nama} · ${t.dimensi}', style: const TextStyle(fontSize: 9, color: Colors.white54)),
                ],
              ),
            ),
            _buildCategoryPill(t.kategori),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPill(String cat) {
    Color badgeColor;
    switch (cat) {
      case 'kosan':
        badgeColor = Colors.orangeAccent;
        break;
      case 'diamond':
        badgeColor = Colors.cyanAccent;
        break;
      case 'tebok':
        badgeColor = Colors.purpleAccent;
        break;
      case 'bijian':
        badgeColor = Colors.greenAccent;
        break;
      case 'BP':
        badgeColor = Colors.pinkAccent;
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
                _activeDetailTab = 'Bagian Sangkar'; // Reset active tab
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
      const Dialog(
        backgroundColor: Colors.transparent,
        child: CreateTemplateWizardDialog(),
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

  // ==========================================
  // BAGIAN SANGKAR TAB COMPONENT
  // ==========================================
  Widget _buildBagianSangkarTab(TemplateSangkar t, JenisSangkar sangkar) {
    final listBagian = sangkar.bagian.map((b) => b.nama).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab Header containing the switch toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Detail Komponen Fisik',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            // Dynamic Toggle: Desain Decal / Pola Polos
            Container(
              height: 28,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color(0xFF101B2D),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _showDecalPattern = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: _showDecalPattern ? Colors.cyanAccent : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Desain Decal',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: _showDecalPattern ? Colors.black : Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _showDecalPattern = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: !_showDecalPattern ? Colors.cyanAccent : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Pola Polos',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: !_showDecalPattern ? Colors.black : Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final double w = constraints.maxWidth;
            int cols = 3;
            double aspect = 0.85;
            if (w < 480) {
              cols = 1;
              aspect = 1.6;
            } else if (w < 750) {
              cols = 2;
              aspect = 0.95;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listBagian.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: aspect,
              ),
              itemBuilder: (context, idx) {
                final partName = listBagian[idx];
                final sizeStr = _getPartSize(partName, sangkar.id);

                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF101B2D),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image Preview
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _tampilkanPreviewGambarBagian(context, partName, sizeStr),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                _buildPartImageWidget(partName),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.fullscreen_rounded,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Details (Name & Size)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              partName,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.straighten_rounded,
                                  size: 10,
                                  color: Colors.cyanAccent,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    sizeStr,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      color: Colors.white70,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _tampilkanPreviewGambarBagian(
      BuildContext context, String name, String sizeStr) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 550),
          decoration: BoxDecoration(
            color: const Color(0xFF0C0A19),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.cyanAccent, width: 0.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text('Ukuran: $sizeStr', style: const TextStyle(fontSize: 10, color: Colors.cyanAccent)),
                  ],
                ),
                leading: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white60),
                  onPressed: () => Get.back(),
                ),
                actions: [
                  TextButton.icon(
                    onPressed: () {
                      Get.dialog(
                        Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0C0A19),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.cyanAccent, width: 0.5),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  title: const Text('Lembar Layout Decal Lengkap', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                                  leading: IconButton(
                                    icon: const Icon(Icons.close, color: Colors.white60),
                                    onPressed: () => Get.back(),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: InteractiveViewer(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset('assets/images/decal_layout.jpg', fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.grid_view_rounded, size: 12, color: Colors.cyanAccent),
                    label: const Text('Lembar Lengkap', style: TextStyle(fontSize: 10, color: Colors.cyanAccent)),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: InteractiveViewer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildPartImageWidget(name),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPartSize(String partName, String sangkarId) {
    final sangkar = _sangkarController.cages.firstWhere((s) => s.id == sangkarId, orElse: () => _sangkarController.cages.first);
    final part = sangkar.bagian.firstWhere(
      (b) => b.nama == partName,
      orElse: () => BagianSangkar(kode: '', nama: partName, ukuran: 'Standar', bentukArea: 'Datar', perluDecal: false),
    );
    return part.ukuran;
  }

  Widget _buildPartImageWidget(String partName) {
    final cleanName = partName.toLowerCase();
    String matchedName = 'Kaki Kaki';
    if (cleanName.contains('cantolan')) {
      matchedName = 'Cantolan';
    } else if (cleanName.contains('raen')) {
      matchedName = 'Raen';
    } else if (cleanName.contains('pintu')) {
      matchedName = 'Pintu';
    } else if (cleanName.contains('alas')) {
      matchedName = 'Alas Bawah';
    } else if (cleanName.contains('kaki')) {
      matchedName = 'Kaki Kaki';
    } else if (cleanName.contains('tutup')) {
      matchedName = 'Tutup Atas';
    } else if (cleanName.contains('pelengkung')) {
      matchedName = 'Pelengkung';
    } else if (cleanName.contains('cagak')) {
      matchedName = 'Cagak';
    } else {
      matchedName = 'Pintu';
    }

    if (matchedName == 'Kaki Kaki') {
      if (!_showDecalPattern) {
        return Container(
          color: Colors.white,
          child: ClipRect(
            child: FractionallySizedBox(
              widthFactor: 1.25,
              heightFactor: 4.1,
              alignment: const Alignment(0.05, 0.95),
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFFA0A0A0),
                  BlendMode.srcATop,
                ),
                child: Image.asset(
                  'assets/images/kaki_kaki_raw.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      } else {
        return Container(
          color: const Color(0xFF0C0A19),
          child: ClipRect(
            child: FractionallySizedBox(
              widthFactor: 1.25,
              heightFactor: 4.1,
              alignment: const Alignment(0.05, 0.95),
              child: Image.asset(
                'assets/images/kaki_kaki_raw.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      }
    }

    Widget imageWidget;

    if (matchedName == 'Cantolan') {
      imageWidget = Image.asset(
        !_showDecalPattern ? 'assets/images/cantolan_polos.png' : 'assets/images/cantolan.png',
        fit: BoxFit.contain,
      );
    } else if (matchedName == 'Pelengkung') {
      imageWidget = Image.asset(
        'assets/images/pelengkung.png',
        fit: BoxFit.contain,
      );
    } else if (matchedName == 'Alas Bawah') {
      imageWidget = Image.asset(
        !_showDecalPattern ? 'assets/images/alas_bawah_polos.png' : 'assets/images/alas_bawah.png',
        fit: BoxFit.contain,
      );
    } else if (matchedName == 'Cagak') {
      imageWidget = Image.asset(
        'assets/images/cagak.png',
        fit: BoxFit.contain,
      );
    } else if (matchedName == 'Raen') {
      imageWidget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/raen_atas.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Image.asset(
              'assets/images/raen_bawah.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      );
    } else if (matchedName == 'Pintu') {
      imageWidget = Image.asset(
        'assets/images/pintu.png',
        fit: BoxFit.contain,
      );
    } else if (matchedName == 'Tutup Atas') {
      imageWidget = Image.asset(
        'assets/images/tutup_atas.png',
        fit: BoxFit.contain,
      );
    } else {
      const assetPath = 'assets/images/decal_layout.jpg';
      imageWidget = ClipRect(
        child: FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 1.0,
          alignment: Alignment.center,
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    final t = _viewingDetailTemplate;
    if (_showDecalPattern && t != null) {
      final gradient = _getMotifGradient(t.nama);
      return Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.15,
                child: CustomPaint(
                  painter: DecalGridPainter(),
                ),
              ),
            ),
            Center(
              child: Opacity(
                opacity: 0.85,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.white70,
                    BlendMode.srcIn,
                  ),
                  child: imageWidget,
                ),
              ),
            ),
            Positioned(
              bottom: 6,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  partName.split(':').last.trim().toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: !_showDecalPattern ? Colors.white : const Color(0xFF0C0A19),
      alignment: Alignment.center,
      padding: matchedName == 'Raen' ? const EdgeInsets.symmetric(vertical: 4, horizontal: 8) : EdgeInsets.zero,
      child: !_showDecalPattern && matchedName != 'Cantolan' && matchedName != 'Alas Bawah'
          ? ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color(0xFFA0A0A0),
                BlendMode.srcIn,
              ),
              child: imageWidget,
            )
          : imageWidget,
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

class CreateTemplateWizardDialog extends StatefulWidget {
  const CreateTemplateWizardDialog({super.key});

  @override
  State<CreateTemplateWizardDialog> createState() => _CreateTemplateWizardDialogState();
}

class _CreateTemplateWizardDialogState extends State<CreateTemplateWizardDialog> {
  final SangkarController _controller = Get.find<SangkarController>();
  int _step = 1; // 1: Select Cage, 2: Select/Generate Motif, 3: Save Name

  JenisSangkar? _selectedCage;
  String? _selectedMotifName;
  String _aiPrompt = '';
  bool _isGeneratingAI = false;
  String _aiStatus = '';
  final TextEditingController _namaController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 650, maxHeight: 520),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0A19),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyanAccent, width: 0.5),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BUAT TEMPLATE BARU — LANGKAH $_step DARI 3',
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
                IconButton(icon: const Icon(Icons.close, color: Colors.white54, size: 18), onPressed: () => Get.back()),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 1),

          // Main Wizard Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildWizardStepContent(),
            ),
          ),

          // Footer buttons
          const Divider(color: Colors.white10, height: 1),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                _step > 1
                    ? OutlinedButton(
                        onPressed: () => setState(() => _step--),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white70,
                          side: const BorderSide(color: Colors.white24),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Sebelumnya', style: TextStyle(fontSize: 11)),
                      )
                    : const SizedBox.shrink(),

                // Next / Save button
                ElevatedButton(
                  onPressed: _onNextPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    _step == 3 ? 'Simpan Template' : 'Selanjutnya',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWizardStepContent() {
    if (_step == 1) {
      // Step 1: Select physical cage
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Langkah 1: Pilih Kerangka Fisik Sangkar', style: TextStyle(color: Colors.cyanAccent, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Template akan dibuat berdasarkan dimensi dan komponen kerangka fisik ini.', style: TextStyle(color: Colors.white54, fontSize: 10)),
          const SizedBox(height: 16),
          ..._controller.cages.map((c) {
            final isSelected = _selectedCage?.id == c.id;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.cyan.withValues(alpha: 0.1) : const Color(0xFF101B2D),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isSelected ? Colors.cyanAccent : Colors.transparent, width: 0.5),
              ),
              child: ListTile(
                title: Text(c.nama, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                subtitle: Text('${c.bentuk} • ${c.bagian.length} Bagian • ${c.ukuranTotal}', style: const TextStyle(color: Colors.white54, fontSize: 10)),
                trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.cyanAccent, size: 18) : null,
                onTap: () => setState(() => _selectedCage = c),
              ),
            );
          }),
        ],
      );
    } else if (_step == 2) {
      // Step 2: Choose / Generate decal design
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Langkah 2: Pilih Desain Decal / Motif', style: TextStyle(color: Colors.cyanAccent, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Gunakan katalog preset atau buat motif baru menggunakan AI generator.', style: TextStyle(color: Colors.white54, fontSize: 10)),
          const SizedBox(height: 20),

          // Presets Catalog Title
          const Text('Gambar Desain dari Database:', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: DummyDb.desainDecal.map((d) {
                final isSelected = _selectedMotifName == d.nama;
                return InkWell(
                  onTap: () => setState(() {
                    _selectedMotifName = d.nama;
                    _aiPrompt = ''; // Reset AI prompt
                  }),
                  child: Container(
                    width: 155,
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.cyan.withValues(alpha: 0.1) : const Color(0xFF101B2D),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isSelected ? Colors.cyanAccent : Colors.white10, width: 0.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d.nama,
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text('Motif: ${d.motif}', style: const TextStyle(color: Colors.cyanAccent, fontSize: 8), maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text('Resolusi: ${d.resolusi}', style: const TextStyle(color: Colors.white30, fontSize: 8)),
                        Text('Desainer: ${d.desainer}', style: const TextStyle(color: Colors.white30, fontSize: 8), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),

          // AI Generator Input
          const Text('Buat dengan AI Generator:', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                  decoration: InputDecoration(
                    hintText: 'Tulis prompt AI (misal: "Ornamen naga mistik dengan percikan bara api") ...',
                    hintStyle: const TextStyle(color: Colors.white24, fontSize: 11),
                    filled: true,
                    fillColor: const Color(0xFF101B2D),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                  onChanged: (val) => _aiPrompt = val,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _aiPrompt.trim().isEmpty ? null : _generateAIImage,
                icon: const Icon(Icons.auto_awesome, size: 12, color: Colors.black),
                label: const Text('Generate', style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          if (_isGeneratingAI) ...[
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.cyanAccent, strokeWidth: 2),
                  ),
                  const SizedBox(height: 8),
                  Text(_aiStatus, style: const TextStyle(color: Colors.cyanAccent, fontSize: 10)),
                ],
              ),
            ),
          ],
        ],
      );
    } else {
      // Step 3: Name & Save
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Langkah 3: Beri Nama & Simpan Template', style: TextStyle(color: Colors.cyanAccent, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text('Nama Template Desain', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _namaController,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            decoration: InputDecoration(
              hintText: 'misal: Kosan R15 Dragon Phoenix Special',
              hintStyle: const TextStyle(color: Colors.white24),
              filled: true,
              fillColor: const Color(0xFF101B2D),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 24),
          // Configuration summary box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF101B2D),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rangkuman Konfigurasi:', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildSummaryLine('Kerangka', _selectedCage?.nama ?? '-'),
                _buildSummaryLine('Dimensi Cetak', _selectedCage?.ukuranTotal ?? '-'),
                _buildSummaryLine('Bentuk', _selectedCage?.bentuk ?? '-'),
                _buildSummaryLine('Desain Motif', _selectedMotifName ?? 'Kustom AI Design'),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _buildSummaryLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white30, fontSize: 10)),
          Text(value, style: const TextStyle(color: Colors.cyanAccent, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _generateAIImage() async {
    setState(() {
      _isGeneratingAI = true;
      _aiStatus = 'Menghubungkan ke AI Engine...';
    });
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _aiStatus = 'Menganalisis prompt...');
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _aiStatus = 'Menggambar pola decal...');
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _isGeneratingAI = false;
      _selectedMotifName = 'AI: ${_aiPrompt.length > 20 ? "${_aiPrompt.substring(0, 18)}..." : _aiPrompt}';
    });
    Get.snackbar(
      'AI GENERATOR',
      'Desain motif kustom berhasil dibuat',
      backgroundColor: const Color(0xFF101B2D),
      colorText: Colors.amberAccent,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _onNextPressed() {
    if (_step == 1) {
      if (_selectedCage == null) {
        Get.snackbar('PERINGATAN', 'Pilih kerangka fisik terlebih dahulu!', backgroundColor: const Color(0xFF0C0A19), colorText: Colors.orangeAccent);
        return;
      }
      setState(() => _step = 2);
    } else if (_step == 2) {
      if (_selectedMotifName == null) {
        Get.snackbar('PERINGATAN', 'Pilih motif dari katalog atau buat dengan AI!', backgroundColor: const Color(0xFF0C0A19), colorText: Colors.orangeAccent);
        return;
      }
      _namaController.text = '${_selectedCage!.nama} - ${_selectedMotifName!}';
      setState(() => _step = 3);
    } else if (_step == 3) {
      final name = _namaController.text.trim();
      if (name.isEmpty) {
        Get.snackbar('PERINGATAN', 'Masukkan nama template!', backgroundColor: const Color(0xFF0C0A19), colorText: Colors.orangeAccent);
        return;
      }

      final newTemplate = TemplateSangkar(
        id: 'TMP-${DateTime.now().millisecondsSinceEpoch}',
        nama: name,
        jenisSangkarId: _selectedCage!.id,
        desainDecalIds: ['DSN-001'],
        thumbnail: 'assets/thumb/tmp001.png',
        popularitas: 90,
        status: 'Aktif',
        dimensi: _selectedCage!.ukuranTotal,
        layers: _selectedCage!.bagian.length * 2,
        kategori: _selectedCage!.nama.toLowerCase().contains('kosan')
            ? 'kosan'
            : _selectedCage!.nama.toLowerCase().contains('diamond')
                ? 'diamond'
                : _selectedCage!.nama.toLowerCase().contains('tebok')
                    ? 'tebok'
                    : _selectedCage!.nama.toLowerCase().contains('bijian')
                        ? 'bijian'
                        : 'BP',
        komponen: {'Frame': 1, 'Ornamen': _selectedCage!.bagian.length, 'Background': 1},
      );

      _controller.addTemplate(newTemplate);

      Get.back();
      Get.snackbar(
        'SUKSES',
        'Template $name berhasil dibuat!',
        backgroundColor: const Color(0xFF101B2D),
        colorText: Colors.cyanAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class Interactive3DView extends StatefulWidget {
  final String shape;
  final String title;
  final String templateName;
  const Interactive3DView({super.key, required this.shape, required this.title, required this.templateName});

  @override
  State<Interactive3DView> createState() => _Interactive3DViewState();
}

class _Interactive3DViewState extends State<Interactive3DView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _rotationAngle = 0.0;
  double _tiltAngle = 0.2; 
  bool _autoSpin = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        if (_autoSpin) {
          setState(() {
            _rotationAngle += 0.01;
          });
        }
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 500),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0A19),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyanAccent, width: 0.5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'PREVIEW 3D SANGKAR: ${widget.title.toUpperCase()}',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white60, size: 18),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          Expanded(
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _autoSpin = false;
                  _rotationAngle += details.delta.dx * 0.01;
                  _tiltAngle = (_tiltAngle - details.delta.dy * 0.01).clamp(-0.5, 0.5);
                });
              },
              child: Container(
                color: const Color(0xFF060D1A),
                width: double.infinity,
                child: CustomPaint(
                  painter: Cage3DPainter(
                    shape: widget.shape,
                    rotation: _rotationAngle,
                    tilt: _tiltAngle,
                    templateName: widget.templateName,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF101B2D),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.rotate_left, color: Colors.cyanAccent, size: 16),
                    SizedBox(width: 8),
                    Text('Geser/Drag area gambar untuk rotasi bebas', style: TextStyle(color: Colors.white54, fontSize: 10)),
                  ],
                ),
                Row(
                  children: [
                    const Text('Auto Spin', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    Switch(
                      value: _autoSpin,
                      activeThumbColor: Colors.cyanAccent,
                      onChanged: (val) {
                        setState(() {
                          _autoSpin = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Cage3DPainter extends CustomPainter {
  final String shape;
  final double rotation;
  final double tilt;
  final String templateName;

  Cage3DPainter({required this.shape, required this.rotation, required this.tilt, required this.templateName});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scale = size.width * 0.25;

    final paintLine = Paint()
      ..color = Colors.cyanAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final paintFill = Paint()
      ..color = Colors.cyanAccent.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final paintAccent = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    int numPoints = 8;
    if (shape.toLowerCase() == 'hexagon') {
      numPoints = 6;
    } else if (shape.toLowerCase() == 'kotak') {
      numPoints = 4;
    } else {
      numPoints = 16; 
    }

    List<Offset> topPoints = [];
    List<Offset> bottomPoints = [];
    List<Offset> middlePoints = []; 

    for (int i = 0; i < numPoints; i++) {
      double angle = (2 * 3.14159 * i / numPoints) + rotation;
      
      double x = math.cos(angle);
      double y = math.sin(angle);
      
      double topZ = -0.8;
      double midZ = 0.5;
      double bottomZ = 0.8;

      topPoints.add(Offset(
        center.dx + scale * x,
        center.dy + scale * (y * math.sin(tilt) + topZ),
      ));

      middlePoints.add(Offset(
        center.dx + scale * x,
        center.dy + scale * (y * math.sin(tilt) + midZ),
      ));

      bottomPoints.add(Offset(
        center.dx + scale * x,
        center.dy + scale * (y * math.sin(tilt) + bottomZ),
      ));
    }

    final pathAlas = Path()..moveTo(bottomPoints[0].dx, bottomPoints[0].dy);
    for (int i = 1; i < numPoints; i++) {
      pathAlas.lineTo(bottomPoints[i].dx, bottomPoints[i].dy);
    }
    pathAlas.close();
    canvas.drawPath(pathAlas, paintFill);
    canvas.drawPath(pathAlas, paintLine);

    final pathDecal = Path()..moveTo(middlePoints[0].dx, middlePoints[0].dy);
    for (int i = 1; i < numPoints; i++) {
      pathDecal.lineTo(middlePoints[i].dx, middlePoints[i].dy);
    }
    for (int i = numPoints - 1; i >= 0; i--) {
      pathDecal.lineTo(bottomPoints[i].dx, bottomPoints[i].dy);
    }
    pathDecal.close();
    
    final gradient = _getMotifGradient(templateName);
    final rect = Rect.fromCircle(center: center, radius: scale);
    final paintDecalFill = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;
    canvas.drawPath(pathDecal, paintDecalFill);

    for (int i = 0; i < numPoints; i++) {
      canvas.drawLine(topPoints[i], bottomPoints[i], paintLine..strokeWidth = 0.8);
    }

    final pathTop = Path()..moveTo(topPoints[0].dx, topPoints[0].dy);
    for (int i = 1; i < numPoints; i++) {
      pathTop.lineTo(topPoints[i].dx, topPoints[i].dy);
    }
    pathTop.close();
    canvas.drawPath(pathTop, paintLine..strokeWidth = 1.5);

    final topCenterPoint = Offset(center.dx, center.dy + scale * (-1.4));
    for (int i = 0; i < numPoints; i += numPoints ~/ 4) {
      canvas.drawLine(topPoints[i], topCenterPoint, paintAccent);
    }
    
    canvas.drawCircle(topCenterPoint, 8, paintLine..strokeWidth = 1.5);
  }

  @override
  bool shouldRepaint(covariant Cage3DPainter oldDelegate) {
    return oldDelegate.rotation != rotation || oldDelegate.tilt != tilt || oldDelegate.shape != shape || oldDelegate.templateName != templateName;
  }
}

class PdfPrintLayoutView extends StatelessWidget {
  final TemplateSangkar template;
  final JenisSangkar cage;
  const PdfPrintLayoutView({super.key, required this.template, required this.cage});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0A19),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyanAccent, width: 0.5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PRINTOUT SHEET / POTONGAN DECAL: ${template.nama.toUpperCase()}',
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Layout cetak skala 1:1 dilengkapi batas potong (crop marks) dan kode percetakan',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 10),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white60, size: 18),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                _buildCmykCircle(Colors.cyan),
                                const SizedBox(width: 4),
                                _buildCmykCircle(const Color(0xFFFF00FF)),
                                const SizedBox(width: 4),
                                _buildCmykCircle(Colors.yellow),
                                const SizedBox(width: 4),
                                _buildCmykCircle(Colors.black),
                                const SizedBox(width: 12),
                                const Text(
                                  'REGISTRATION MARK • A4 STICKER MATTE',
                                  style: TextStyle(color: Colors.black54, fontSize: 7, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              'JOB_ID: TMP-${template.id.substring(template.id.length - 6)}',
                              style: const TextStyle(color: Colors.black54, fontSize: 7, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: Colors.black12, height: 1),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: cage.bagian.map((b) {
                            final gradient = _getMotifGradient(template.nama);
                            return Container(
                              width: 160,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border.all(color: Colors.black38, width: 0.5, style: BorderStyle.solid),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(Icons.crop_free, size: 10, color: Colors.black38),
                                      Text(
                                        b.bentukArea.toUpperCase(),
                                        style: const TextStyle(fontSize: 6, color: Colors.black45, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 70,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: gradient,
                                    ),
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Opacity(
                                            opacity: 0.15,
                                            child: CustomPaint(
                                              painter: DecalGridPainter(),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            b.kode,
                                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black45, blurRadius: 4)]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    b.nama,
                                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Ukuran: ${b.ukuran}',
                                    style: const TextStyle(fontSize: 8, color: Colors.black54),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF101B2D),
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
                  child: const Text('Tutup', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      'CETAK PDF',
                      'Menyiapkan layout PDF dan mengirim ke antrean printer...',
                      backgroundColor: const Color(0xFF101B2D),
                      colorText: Colors.cyanAccent,
                      icon: const Icon(Icons.print, color: Colors.cyanAccent),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  icon: const Icon(Icons.print, size: 14, color: Colors.black),
                  label: const Text('Kirim ke Printer / PDF', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCmykCircle(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black26, width: 0.5),
      ),
    );
  }
}

LinearGradient _getMotifGradient(String motifName) {
  final name = motifName.toLowerCase();
  if (name.contains('dragon') || name.contains('red') || name.contains('fire') || name.contains('naga')) {
    return const LinearGradient(
      colors: [Color(0xFF6B0000), Color(0xFFE63900), Color(0xFFFF9900)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  } else if (name.contains('tiger') || name.contains('shaman') || name.contains('green') || name.contains('harimau')) {
    return const LinearGradient(
      colors: [Color(0xFF071208), Color(0xFF00FF66), Color(0xFF003311)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  } else if (name.contains('phoenix') || name.contains('gold') || name.contains('orange')) {
    return const LinearGradient(
      colors: [Color(0xFFFF3300), Color(0xFFFF9900), Color(0xFF3B0054)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  } else if (name.contains('eagle') || name.contains('blue') || name.contains('hunter') || name.contains('rajawali')) {
    return const LinearGradient(
      colors: [Color(0xFF001B3B), Color(0xFF0088FF), Color(0xFF00001C)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  } else {
    int hash = motifName.hashCode;
    int hue1 = (hash.abs() % 360);
    int hue2 = ((hash.abs() + 140) % 360);
    final color1 = HSVColor.fromAHSV(1.0, hue1.toDouble(), 0.85, 0.75).toColor();
    final color2 = HSVColor.fromAHSV(1.0, hue2.toDouble(), 0.9, 0.4).toColor();
    return LinearGradient(
      colors: [color1, color2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

class DecalGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    const double step = 15;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final centerPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 15, centerPaint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 3, Paint()..color = Colors.white.withValues(alpha: 0.2));
  }

  @override
  bool shouldRepaint(covariant DecalGridPainter oldDelegate) => false;
}
