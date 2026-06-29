import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup03/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup03/models/sangkar_models.dart';

class DesainPage extends StatefulWidget {
  const DesainPage({super.key});

  @override
  State<DesainPage> createState() => _DesainPageState();
}

class _DesainPageState extends State<DesainPage> {
  late List<DesainDecal> _listDesain;
  late List<String> _listKategori;

  @override
  void initState() {
    super.initState();
    _listDesain = List.from(DummyDb.desainDecal);
    _listKategori = ['Abstract', 'Hewan', 'Racing', 'Khas Nusantara', 'Ukiran', 'Geometris'];
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DESIGN CATALOG',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text('Clean minimalist view with detail bottom sheet', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () => _tampilkanDialogGenerasiAI(context),
                icon: const Icon(Icons.add, size: 14, color: Colors.black87),
                label: const Text('Add with AI', style: TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black87),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: _listDesain.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, idx) {
                final d = _listDesain[idx];
                return GestureDetector(
                  onTap: () => _tampilkanBottomSheetDetail(context, d, idx),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                            child: Image.network(_getImageUrlForDesain(d), fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 2),
                              Text('${d.kategori} · ${d.ukuran}', style: const TextStyle(color: Colors.grey, fontSize: 9)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _tampilkanBottomSheetDetail(BuildContext context, DesainDecal d, int idx) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(d.nama, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  IconButton(icon: const Icon(Icons.close, size: 18), onPressed: () => Get.back()),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(_getImageUrlForDesain(d), width: 140, height: 140, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: [
                        _buildRow('ID', d.id),
                        _buildRow('Kategori', d.kategori),
                        _buildRow('Motif', d.motif),
                        _buildRow('Dimensi', d.ukuran),
                        _buildRow('Format', d.format),
                        _buildRow('Desainer', d.desainer),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.delete_outline, size: 14, color: Colors.white),
                label: const Text('Hapus Desain'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: () {
                  setState(() {
                    _listDesain.removeAt(idx);
                  });
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10))),
          Expanded(child: Text(val, style: const TextStyle(color: Colors.black87, fontSize: 10))),
        ],
      ),
    );
  }

  void _tampilkanDialogGenerasiAI(BuildContext context) {
    final TextEditingController promptController = TextEditingController();
    final TextEditingController namaController = TextEditingController();
    String selectedKategori = 'Abstract';

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Add Design', style: TextStyle(color: Colors.black87, fontSize: 14)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: promptController, decoration: const InputDecoration(labelText: 'AI Prompt'), style: const TextStyle(color: Colors.black87)),
            TextField(controller: namaController, decoration: const InputDecoration(labelText: 'Design Name'), style: const TextStyle(color: Colors.black87)),
            DropdownButton<String>(
              value: selectedKategori,
              items: _listKategori.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: Colors.black87)))).toList(),
              onChanged: (val) => setState(() => selectedKategori = val!),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (promptController.text.isEmpty) return;
              final newDecal = DesainDecal(
                id: 'DSN-${DateTime.now().millisecondsSinceEpoch}',
                nama: namaController.text.isEmpty ? 'AI Design' : namaController.text,
                kategori: selectedKategori,
                motif: 'AI motif',
                ukuran: '30 × 20 cm',
                format: 'PNG',
                resolusi: '300 dpi',
                desainer: 'AI Generator',
                tanggalBuat: '29 Jun 2026',
                status: 'Aktif',
                imageUrl: 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(promptController.text)}?width=512&height=512&nologo=true',
              );
              setState(() {
                _listDesain.insert(0, newDecal);
              });
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
