import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup02/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup02/models/sangkar_models.dart';

class DesainPage extends StatefulWidget {
  const DesainPage({super.key});

  @override
  State<DesainPage> createState() => _DesainPageState();
}

class _DesainPageState extends State<DesainPage> {
  late List<DesainDecal> _listDesain;
  late List<String> _listKategori;
  late List<Map<String, String>> _listSavedPrompts;
  int _selectedIdx = 0;

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
    ];
  }

  String _getImageUrlForDesain(DesainDecal d) {
    if (d.imageUrl != null && d.imageUrl!.isNotEmpty) {
      return d.imageUrl!;
    }
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
    final bool hasData = _listDesain.isNotEmpty;
    if (_selectedIdx >= _listDesain.length) {
      _selectedIdx = 0;
    }
    final selectedDecal = hasData
        ? _listDesain[_selectedIdx]
        : const DesainDecal(
            id: '',
            nama: '',
            kategori: '',
            motif: '',
            ukuran: '',
            format: '',
            resolusi: '',
            desainer: '',
            tanggalBuat: '',
            status: '',
          );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF140224),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'KATALOG DESAIN DECAL (NEON SPLIT)',
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
                    style: const TextStyle(fontSize: 10, color: Colors.purpleAccent),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _tampilkanDialogGenerasiAI(context),
                icon: const Icon(Icons.auto_awesome, size: 14, color: Colors.black),
                label: const Text('Buat Desain AI', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Master Detail Split Screen
          Expanded(
            child: !hasData
                ? const Center(
                    child: Text('Belum ada data stiker decal.', style: TextStyle(color: Colors.white38)),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Master List (Left Pane)
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0014),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: ListView.separated(
                            itemCount: _listDesain.length,
                            separatorBuilder: (context, index) => const Divider(color: Colors.white10, height: 1),
                            itemBuilder: (context, idx) {
                              final d = _listDesain[idx];
                              final isSelected = idx == _selectedIdx;
                              return ListTile(
                                tileColor: isSelected ? Colors.purpleAccent.withValues(alpha: 0.1) : Colors.transparent,
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                      image: NetworkImage(_getImageUrlForDesain(d)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  d.nama,
                                  style: TextStyle(
                                    color: isSelected ? Colors.purpleAccent : Colors.white,
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  '${d.kategori} · ${d.ukuran}',
                                  style: const TextStyle(color: Colors.white38, fontSize: 10),
                                ),
                                onTap: () => setState(() => _selectedIdx = idx),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Detail Preview (Right Pane)
                      Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0014),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.2)),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Large Zoomable Image
                                GestureDetector(
                                  onTap: () => _tampilkanPreviewGambar(context, _getImageUrlForDesain(selectedDecal), selectedDecal.nama),
                                  child: Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.white10),
                                      image: DecorationImage(
                                        image: NetworkImage(_getImageUrlForDesain(selectedDecal)),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    alignment: Alignment.topRight,
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                                      child: const Icon(Icons.fullscreen, color: Colors.white, size: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Title Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selectedDecal.nama,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.purpleAccent.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(selectedDecal.format, style: const TextStyle(color: Colors.purpleAccent, fontSize: 9, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Table detail
                                _buildSpecRow('Kategori', selectedDecal.kategori),
                                _buildSpecRow('Motif', selectedDecal.motif),
                                _buildSpecRow('Dimensi', selectedDecal.ukuran),
                                _buildSpecRow('Resolusi', selectedDecal.resolusi),
                                _buildSpecRow('Desainer', selectedDecal.desainer),
                                _buildSpecRow('Tanggal', selectedDecal.tanggalBuat),

                                const Divider(color: Colors.white10, height: 24),

                                // Action Buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.delete_outline, size: 14, color: Colors.white),
                                      label: const Text('Hapus Desain', style: TextStyle(fontSize: 11, color: Colors.white)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      ),
                                      onPressed: () => _konfirmasiHapusDesain(context, _selectedIdx, selectedDecal),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11))),
          Expanded(child: Text(val, style: const TextStyle(color: Colors.white, fontSize: 11))),
        ],
      ),
    );
  }

  void _tampilkanPreviewGambar(BuildContext context, String imageUrl, String name) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
          decoration: BoxDecoration(
            color: const Color(0xFF0C0A19),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(name, style: const TextStyle(fontSize: 14, color: Colors.white)),
                leading: IconButton(icon: const Icon(Icons.close, color: Colors.white60), onPressed: () => Get.back()),
              ),
              Expanded(
                child: InteractiveViewer(
                  child: Image.network(imageUrl, fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _konfirmasiHapusDesain(BuildContext context, int index, DesainDecal d) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0A0014),
        title: const Text('Hapus Desain?', style: TextStyle(color: Colors.white, fontSize: 14)),
        content: Text('Hapus stiker "${d.nama}"?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Batal', style: TextStyle(color: Colors.white38))),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _listDesain.removeAt(index);
                if (_selectedIdx >= _listDesain.length && _listDesain.isNotEmpty) {
                  _selectedIdx = _listDesain.length - 1;
                }
              });
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

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
            return const AlertDialog(
              backgroundColor: Color(0xFF0C0A19),
              content: SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator(color: Colors.purpleAccent)),
              ),
            );
          }
          return AlertDialog(
            backgroundColor: const Color(0xFF0C0A19),
            title: const Text('GENERATOR DESAIN AI', style: TextStyle(color: Colors.white, fontSize: 13)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Prompt', style: TextStyle(color: Colors.white38, fontSize: 10)),
                    GestureDetector(
                      onTap: () => _tampilkanDialogPilihPrompt(context, promptController, setDialogState),
                      child: const Text('Pilih Saved', style: TextStyle(color: Colors.purpleAccent, fontSize: 10)),
                    ),
                  ],
                ),
                TextField(controller: promptController, style: const TextStyle(color: Colors.white, fontSize: 11)),
                TextField(controller: namaController, decoration: const InputDecoration(hintText: 'Nama Desain'), style: const TextStyle(color: Colors.white, fontSize: 11)),
                DropdownButton<String>(
                  value: selectedKategori,
                  dropdownColor: const Color(0xFF0C0A19),
                  style: const TextStyle(color: Colors.white),
                  items: _listKategori.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                  onChanged: (val) => setDialogState(() => selectedKategori = val!),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: const Text('Batal')),
              ElevatedButton(
                onPressed: () async {
                  final prompt = promptController.text.trim();
                  if (prompt.isEmpty) return;
                  final bool? save = await Get.dialog<bool>(
                    AlertDialog(
                      backgroundColor: const Color(0xFF0C0A19),
                      title: const Text('Simpan Prompt?', style: TextStyle(color: Colors.white, fontSize: 12)),
                      actions: [
                        TextButton(onPressed: () => Get.back(result: false), child: const Text('Tidak')),
                        ElevatedButton(onPressed: () => Get.back(result: true), child: const Text('Ya')),
                      ],
                    ),
                  );
                  if (save == null) return;
                  if (save) {
                    setState(() {
                      _listSavedPrompts.add({'title': namaController.text, 'prompt': prompt});
                    });
                  }
                  setDialogState(() => isGenerating = true);
                  await Future.delayed(const Duration(milliseconds: 1500));
                  final newDecal = DesainDecal(
                    id: 'DSN-${DateTime.now().millisecondsSinceEpoch}',
                    nama: namaController.text.isEmpty ? 'AI Design' : namaController.text,
                    kategori: selectedKategori,
                    motif: motifController.text,
                    ukuran: '30 × 20 cm',
                    format: 'PNG',
                    resolusi: '300 dpi',
                    desainer: 'AI Generator',
                    tanggalBuat: '29 Jun 2026',
                    status: 'Aktif',
                    imageUrl: 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(prompt)}?width=512&height=512&nologo=true',
                  );
                  setState(() {
                    _listDesain.insert(0, newDecal);
                  });
                  Get.back();
                },
                child: const Text('Generate'),
              )
            ],
          );
        },
      ),
    );
  }

  void _tampilkanDialogPilihPrompt(BuildContext context, TextEditingController promptController, StateSetter setDialogState) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0C0A19),
        title: const Text('PILIH PROMPT', style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: 300,
          height: 200,
          child: ListView(
            children: _listSavedPrompts.map((p) {
              return ListTile(
                title: Text(p['title']!, style: const TextStyle(color: Colors.white, fontSize: 12)),
                subtitle: Text(p['prompt']!, style: const TextStyle(color: Colors.white38, fontSize: 10), maxLines: 1),
                onTap: () {
                  setDialogState(() {
                    promptController.text = p['prompt']!;
                  });
                  Get.back();
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
