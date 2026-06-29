import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup01/models/sangkar_models.dart';

class DesainPage extends StatefulWidget {
  const DesainPage({super.key});

  @override
  State<DesainPage> createState() => _DesainPageState();
}

class _DesainPageState extends State<DesainPage> {
  late List<DesainDecal> _listDesain;
  late List<String> _listKategori;
  late List<Map<String, String>> _listSavedPrompts;

  @override
  void initState() {
    super.initState();
    _listDesain = List.from(DummyDb.desainDecal);
    _listKategori = ['Abstract', 'Hewan', 'Racing', 'Khas Nusantara', 'Ukiran', 'Geometris'];
    _listSavedPrompts = [
      {
        'title': 'Motif Naga Merah',
        'prompt': 'Red dragon decal, golden fire, dark background, vector art, details lines',
      },
      {
        'title': 'Serat Karbon Premium',
        'prompt': 'Carbon fiber texture, dark graphite lines, seamless premium pattern, neon blue cyan borders',
      },
      {
        'title': 'Ukiran Nusantara',
        'prompt': 'Vintage wood carving texture, floral batik pattern, gold and dark brown gradients, 4k vector',
      },
    ];
  }

  // Get image URL for decal, fallback to static Pollinations prompts if not set
  String _getImageUrlForDesain(DesainDecal d) {
    if (d.imageUrl != null && d.imageUrl!.isNotEmpty) {
      return d.imageUrl!;
    }
    // Fallback based on ID to avoid duplicate images and look clean
    final map = {
      'DSN-001': 'https://image.pollinations.ai/prompt/red%20dragon%20decal%20birdcage%20vector?width=512&height=512&seed=101&nologo=true',
      'DSN-002': 'https://image.pollinations.ai/prompt/black%20tiger%20decal%20birdcage%20vector?width=512&height=512&seed=102&nologo=true',
      'DSN-003': 'https://image.pollinations.ai/prompt/carbon%20fiber%20texture%20seamless%20vector?width=512&height=512&seed=103&nologo=true',
      'DSN-004': 'https://image.pollinations.ai/prompt/gold%20garuda%20wings%20decal%20vector?width=512&height=512&seed=104&nologo=true',
      'DSN-005': 'https://image.pollinations.ai/prompt/phoenix%20decal%20birdcage%20vector?width=512&height=512&seed=105&nologo=true',
      'DSN-006': 'https://image.pollinations.ai/prompt/cyberpunk%20neon%20lines%20vector?width=512&height=512&seed=106&nologo=true',
      'DSN-007': 'https://image.pollinations.ai/prompt/vintage%20wood%20carving%20texture%20vector?width=512&height=512&seed=107&nologo=true',
      'DSN-008': 'https://image.pollinations.ai/prompt/tribal%20flame%20orange%20vector?width=512&height=512&seed=108&nologo=true',
    };
    return map[d.id] ?? 'https://image.pollinations.ai/prompt/abstract%20decal%20vector?width=512&height=512&seed=109&nologo=true';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF091121),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'KATALOG DESAIN DECAL SANGKAR',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Koleksi ${_listDesain.length} motif decal stiker terdaftar dalam sistem',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.cyanAccent,
                      ),
                    ),
                  ],
                ),
              ),
              // ADD BUTTON (AI Generation)
              ElevatedButton.icon(
                onPressed: () => _tampilkanDialogGenerasiAI(context),
                icon: const Icon(Icons.auto_awesome, size: 14, color: Colors.black),
                label: const Text('Buat Desain AI', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Grid Layout
          LayoutBuilder(
            builder: (context, gridConstraints) {
              final gw = gridConstraints.maxWidth;
              int crossAxisCount = 4;
              double childAspectRatio = 0.68;

              if (gw < 500) {
                crossAxisCount = 1;
                childAspectRatio = 1.15;
              } else if (gw < 800) {
                crossAxisCount = 2;
                childAspectRatio = 0.82;
              } else if (gw < 960) {
                crossAxisCount = 3;
                childAspectRatio = 0.76;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _listDesain.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  final d = _listDesain[index];
                  final imageUrl = _getImageUrlForDesain(d);

                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF101B2D),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Image Thumbnail (Clickable for preview)
                        GestureDetector(
                          onTap: () => _tampilkanPreviewGambar(context, imageUrl, d.nama),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 130,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        height: 130,
                                        color: const Color(0xFF060D1A),
                                        alignment: Alignment.center,
                                        child: const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.cyanAccent),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 130,
                                        color: const Color(0xFF060D1A),
                                        alignment: Alignment.center,
                                        child: const Icon(Icons.broken_image_outlined, color: Colors.white24, size: 24),
                                      );
                                    },
                                  ),
                                  // Floating Badge showing if generated by AI
                                  if (d.desainer == 'AI Generator')
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: Colors.cyanAccent.withValues(alpha: 0.85),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.auto_awesome, size: 8, color: Colors.black),
                                            const SizedBox(width: 3),
                                            const Text(
                                              'AI GENERATED',
                                              style: TextStyle(fontSize: 7, color: Colors.black, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  // Preview zoom icon in top right
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.fullscreen_rounded,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Bottom Info Section
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        d.nama,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.cyanAccent.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        d.format,
                                        style: const TextStyle(
                                          fontSize: 8,
                                          color: Colors.cyanAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Motif: ${d.motif} · Kategori: ${d.kategori}',
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Colors.white54,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                const Divider(color: Colors.white10, height: 1),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(Icons.aspect_ratio, size: 10, color: Colors.white38),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              d.ukuran,
                                              style: const TextStyle(fontSize: 9, color: Colors.white70),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Detail Button
                                        IconButton(
                                          constraints: const BoxConstraints(),
                                          padding: const EdgeInsets.all(4),
                                          icon: const Icon(Icons.info_outline_rounded, size: 14, color: Colors.cyanAccent),
                                          tooltip: 'Lihat Detail',
                                          onPressed: () => _tampilkanDetailDesain(context, d),
                                        ),
                                        const SizedBox(width: 4),
                                        // Delete Button
                                        IconButton(
                                          constraints: const BoxConstraints(),
                                          padding: const EdgeInsets.all(4),
                                          icon: const Icon(Icons.delete_outline_rounded, size: 14, color: Colors.redAccent),
                                          tooltip: 'Hapus Desain',
                                          onPressed: () => _konfirmasiHapusDesain(context, index, d),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
      ),
    );
  }

  // ==========================================
  // IMAGE PREVIEW / LIGHTBOX
  // ==========================================
  void _tampilkanPreviewGambar(BuildContext context, String imageUrl, String namaDesain) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
          decoration: BoxDecoration(
            color: const Color(0xFF0C0A19),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        namaDesain,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white60, size: 20),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white10, height: 1),
              // Image display with zoom functionality
              Flexible(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Center(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(color: Colors.cyanAccent),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.broken_image_outlined, color: Colors.white24, size: 64),
                          );
                        },
                      ),
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

  // ==========================================
  // DETAIL VIEW MODAL
  // ==========================================
  void _tampilkanDetailDesain(BuildContext context, DesainDecal d) {
    final imageUrl = _getImageUrlForDesain(d);
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 500,
          decoration: BoxDecoration(
            color: const Color(0xFF0C0A19),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.3)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with design name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              d.nama,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'ID: ${d.id}',
                              style: const TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white60, size: 20),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white10, height: 1),

                // Design Image Section
                Container(
                  height: 200,
                  color: const Color(0xFF060D1A),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.cyanAccent),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image_outlined, color: Colors.white24, size: 48),
                      );
                    },
                  ),
                ),
                const Divider(color: Colors.white10, height: 1),

                // Details Specifications
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildDetailRow('Kategori', d.kategori),
                      _buildDetailRow('Motif Utama', d.motif),
                      _buildDetailRow('Ukuran / Dimensi', d.ukuran),
                      _buildDetailRow('Format File', d.format),
                      _buildDetailRow('Resolusi', d.resolusi),
                      _buildDetailRow('Desainer', d.desainer),
                      _buildDetailRow('Tanggal Dibuat', d.tanggalBuat),
                      _buildDetailRow('Status', d.status, isStatus: true),
                    ],
                  ),
                ),

                const Divider(color: Colors.white10, height: 1),

                // Actions Footer
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'Tutup',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.delete_outline_rounded, size: 14, color: Colors.white),
                        label: const Text(
                          'Hapus Desain',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          // Find index in list
                          final idx = _listDesain.indexWhere((element) => element.id == d.id);
                          Get.back(); // close detail dialog first
                          if (idx != -1) {
                            _konfirmasiHapusDesain(context, idx, d);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ),
          Expanded(
            flex: 3,
            child: isStatus
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: value == 'Aktif'
                            ? Colors.green.withValues(alpha: 0.15)
                            : Colors.orange.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: value == 'Aktif'
                              ? Colors.greenAccent.withValues(alpha: 0.3)
                              : Colors.orangeAccent.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        value,
                        style: TextStyle(
                          color: value == 'Aktif' ? Colors.greenAccent : Colors.orangeAccent,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // CONFIRM DELETE
  // ==========================================
  void _konfirmasiHapusDesain(BuildContext context, int index, DesainDecal d) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0C0A19),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.redAccent, width: 0.5),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 20),
            SizedBox(width: 8),
            Text(
              'HAPUS DESAIN?',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus desain "${d.nama}"? Tindakan ini tidak dapat dibatalkan.',
          style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal', style: TextStyle(color: Colors.white38, fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _listDesain.removeAt(index);
              });
              Get.back(); // close confirmation dialog
              Get.snackbar(
                'Desain Dihapus',
                'Desain "${d.nama}" telah berhasil dihapus.',
                backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                icon: const Icon(Icons.delete_outline, color: Colors.white),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text('Hapus', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // AI GENERATOR DIALOG BOX
  // ==========================================
  void _tampilkanDialogGenerasiAI(BuildContext context) {
    final TextEditingController promptController = TextEditingController();
    final TextEditingController namaController = TextEditingController();
    final TextEditingController motifController = TextEditingController();
    String selectedKategori = 'Abstract';
    bool isGenerating = false;

    Get.dialog(
      StatefulBuilder(
        builder: (context, setDialogState) {
          if (isGenerating) {
            return AlertDialog(
              backgroundColor: const Color(0xFF0C0A19),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
              ),
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(color: Colors.cyanAccent),
                    const SizedBox(height: 20),
                    const Text(
                      'MENULIS MOTIF DECAL DENGAN AI...',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Menghubungkan ke API Pollinations AI (100% Free)',
                      style: TextStyle(color: Colors.cyanAccent, fontSize: 9),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Menciptakan stiker resolusi tinggi secara real-time.',
                      style: TextStyle(color: Colors.white38, fontSize: 9),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return AlertDialog(
            backgroundColor: const Color(0xFF0C0A19),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
            ),
            title: Row(
              children: [
                const Icon(Icons.auto_awesome, color: Colors.cyanAccent, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'GENERATOR DESAIN DECAL AI',
                  style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: SizedBox(
              width: 420,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Masukkan deskripsi detail motif decal yang ingin Anda ciptakan menggunakan algoritma AI generatif gratis.',
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                    const SizedBox(height: 14),

                    // Prompt Field Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Prompt Desain (Gaya, Warna, Detail)', style: TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () => _tampilkanDialogPilihPrompt(context, promptController, setDialogState),
                          child: const MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Row(
                              children: [
                                Icon(Icons.bookmark_outline_rounded, color: Colors.cyanAccent, size: 10),
                                SizedBox(width: 3),
                                Text(
                                  'Pilih Prompt Tersimpan',
                                  style: TextStyle(color: Colors.cyanAccent, fontSize: 9, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: promptController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                      decoration: InputDecoration(
                        hintText: 'Misal: tiger skin texture, blue neon flames, sharp geometric lines, vector art style, clean dark background',
                        hintStyle: const TextStyle(color: Colors.white24, fontSize: 10),
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
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Nama Desain
                    const Text('Nama Desain', style: TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    TextField(
                      controller: namaController,
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                      decoration: _inputDecoration('Misal: Neon Tiger Flame'),
                    ),
                    const SizedBox(height: 12),

                    // Row of Kategori & Motif
                    Row(
                      children: [
                        // Kategori Dropdown
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Kategori', style: TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
                                  GestureDetector(
                                    onTap: () async {
                                      final newKategori = await _tampilkanDialogTambahKategori(context);
                                      if (newKategori != null) {
                                        setDialogState(() {
                                          selectedKategori = newKategori;
                                        });
                                      }
                                    },
                                    child: const Text(
                                      '+ Tambah',
                                      style: TextStyle(
                                        color: Colors.cyanAccent,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Container(
                                height: 38,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF101B2D),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    dropdownColor: const Color(0xFF101B2D),
                                    value: selectedKategori,
                                    isExpanded: true,
                                    icon: const Icon(Icons.arrow_drop_down, color: Colors.cyanAccent, size: 16),
                                    style: const TextStyle(color: Colors.white, fontSize: 11),
                                    items: _listKategori.map((s) {
                                      return DropdownMenuItem(value: s, child: Text(s));
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setDialogState(() => selectedKategori = val);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Motif
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Motif Utama', style: TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              TextField(
                                controller: motifController,
                                style: const TextStyle(color: Colors.white, fontSize: 11),
                                decoration: _inputDecoration('Misal: Harimau Api'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Batal', style: TextStyle(color: Colors.white38, fontSize: 11)),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (promptController.text.trim().isEmpty) {
                    Get.snackbar(
                      'Prompt Kosong',
                      'Harap isi prompt deskripsi desain terlebih dahulu.',
                      backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  // 1. Ask if they want to save the prompt
                  final prompt = promptController.text.trim();
                  final namaVal = namaController.text.trim();

                  final bool? simpanPrompt = await Get.dialog<bool>(
                    AlertDialog(
                      backgroundColor: const Color(0xFF0C0A19),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
                      ),
                      title: const Text('Simpan Prompt Desain?', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      content: const Text(
                        'Apakah Anda ingin menyimpan prompt ini untuk digunakan kembali di masa mendatang?',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text('Tidak Usah', style: TextStyle(color: Colors.white38, fontSize: 11)),
                        ),
                        ElevatedButton(
                          onPressed: () => Get.back(result: true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          child: const Text('Ya, Simpan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );

                  // If user closed dialog or hit cancel:
                  if (simpanPrompt == null) return;

                  // If they wanted to save it:
                  if (simpanPrompt) {
                    final savedTitle = namaVal.isEmpty ? 'Prompt Baru #${_listSavedPrompts.length + 1}' : namaVal;
                    setState(() {
                      _listSavedPrompts.add({
                        'title': savedTitle,
                        'prompt': prompt,
                      });
                    });
                  }

                  // 2. Show loading state in dialog
                  setDialogState(() {
                    isGenerating = true;
                  });

                  // 3. Build the Pollinations URL
                  // We inject decals/birdcage keywords to guide the AI to make a design motif suitable for birdcages!
                  final guidedPrompt = '$prompt, seamless pattern decal stiker motif vector design';
                  final seed = DateTime.now().millisecondsSinceEpoch;
                  final imageUrl = 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(guidedPrompt)}?width=512&height=512&nologo=true&seed=$seed';

                  // 4. Wait for 2.5s simulation of generation
                  await Future.delayed(const Duration(milliseconds: 2500));

                  // 5. Create new decal
                  final motifVal = motifController.text.trim();

                  final newDecal = DesainDecal(
                    id: 'DSN-${DateTime.now().millisecondsSinceEpoch}',
                    nama: namaVal.isEmpty ? 'AI Generated Motif' : namaVal,
                    kategori: selectedKategori,
                    motif: motifVal.isEmpty ? 'AI Motif' : motifVal,
                    ukuran: '30 × 20 cm',
                    format: 'PNG',
                    resolusi: '300 dpi',
                    desainer: 'AI Generator',
                    tanggalBuat: '27 Jun 2026',
                    status: 'Aktif',
                    imageUrl: imageUrl,
                  );

                  // 6. Add to local list and close dialog
                  setState(() {
                    _listDesain.insert(0, newDecal); // Insert at first index to show immediately!
                  });

                  Get.back(); // Close dialog

                  Get.snackbar(
                    'Sukses Generasi',
                    'Desain AI baru "${newDecal.nama}" berhasil digenerasikan & ditambahkan!',
                    backgroundColor: Colors.green.withValues(alpha: 0.8),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Generate & Tambah', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }

  // ==========================================
  // CHOOSE SAVED PROMPT DIALOG
  // ==========================================
  void _tampilkanDialogPilihPrompt(
      BuildContext context, TextEditingController promptController, StateSetter setDialogState) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0C0A19),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
        ),
        title: const Row(
          children: [
            Icon(Icons.bookmark_outline_rounded, color: Colors.cyanAccent, size: 18),
            SizedBox(width: 8),
            Text(
              'PROMPT TERSIMPAN',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: SizedBox(
          width: 400,
          height: 300,
          child: _listSavedPrompts.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada prompt tersimpan.',
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: _listSavedPrompts.length,
                  separatorBuilder: (context, index) => const Divider(color: Colors.white10, height: 1),
                  itemBuilder: (context, index) {
                    final item = _listSavedPrompts[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item['title'] ?? '',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        item['prompt'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white54, fontSize: 10),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.cyanAccent, size: 12),
                      onTap: () {
                        setDialogState(() {
                          promptController.text = item['prompt'] ?? '';
                        });
                        Get.back(); // close list prompt dialog
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Tutup', style: TextStyle(color: Colors.white38, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // ADD NEW CATEGORY DIALOG
  // ==========================================
  Future<String?> _tampilkanDialogTambahKategori(BuildContext context) {
    final TextEditingController kategoriController = TextEditingController();

    return Get.dialog<String>(
      AlertDialog(
        backgroundColor: const Color(0xFF0C0A19),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
        ),
        title: const Row(
          children: [
            Icon(Icons.category_rounded, color: Colors.cyanAccent, size: 18),
            SizedBox(width: 8),
            Text(
              'TAMBAH KATEGORI BARU',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nama Kategori', style: TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            TextField(
              controller: kategoriController,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 11),
              decoration: _inputDecoration('Misal: Cyberpunk, Retro, Vintage'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal', style: TextStyle(color: Colors.white38, fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () {
              final newKategori = kategoriController.text.trim();
              if (newKategori.isEmpty) {
                Get.snackbar(
                  'Gagal',
                  'Nama kategori tidak boleh kosong.',
                  backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }
              if (_listKategori.contains(newKategori)) {
                Get.snackbar(
                  'Gagal',
                  'Kategori "$newKategori" sudah ada.',
                  backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }

              setState(() {
                _listKategori.add(newKategori);
              });

              Get.back(result: newKategori);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text('Tambah', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white24, fontSize: 10),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    );
  }
}
