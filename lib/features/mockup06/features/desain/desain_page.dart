import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup06/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup06/models/sangkar_models.dart';

class DesainPage extends StatefulWidget {
  const DesainPage({super.key});

  @override
  State<DesainPage> createState() => _DesainPageState();
}

class _DesainPageState extends State<DesainPage> {
  late List<DesainDecal> _listDesain;
  int? _expandedIdx;

  @override
  void initState() {
    super.initState();
    _listDesain = List.from(DummyDb.desainDecal);
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
        color: const Color(0xFF04140C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.15)),
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
                    'FOREST DESIGN LIST (ROW VIEW)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.greenAccent, letterSpacing: 1.2),
                  ),
                  SizedBox(height: 4),
                  Text('Interactive table list layout with inline expansion', style: TextStyle(fontSize: 10, color: Colors.greenAccent)),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _tampilkanDialogGenerasiAI(context),
                icon: const Icon(Icons.add, size: 14, color: Colors.black87),
                label: const Text('Add Forest Decal', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _listDesain.length,
              itemBuilder: (context, idx) {
                final d = _listDesain[idx];
                final isExpanded = idx == _expandedIdx;

                return Column(
                  children: [
                    InkWell(
                      onTap: () => setState(() => _expandedIdx = isExpanded ? null : idx),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isExpanded ? Colors.green.withValues(alpha: 0.08) : Colors.transparent,
                          border: const Border(bottom: BorderSide(color: Colors.white10)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(image: NetworkImage(_getImageUrlForDesain(d)), fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: Text(d.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(d.kategori, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(d.ukuran, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                            ),
                            IconButton(
                              icon: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.greenAccent, size: 18),
                              onPressed: () => setState(() => _expandedIdx = isExpanded ? null : idx),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isExpanded)
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.white.withValues(alpha: 0.02),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(_getImageUrlForDesain(d), width: 120, height: 120, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailItem('ID Desain', d.id),
                                  _buildDetailItem('Motif Utama', d.motif),
                                  _buildDetailItem('Format & Resolusi', '${d.format} · ${d.resolusi}'),
                                  _buildDetailItem('Dibuat Oleh', d.desainer),
                                  _buildDetailItem('Tanggal Buat', d.tanggalBuat),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _listDesain.removeAt(idx);
                                      _expandedIdx = null;
                                    });
                                  },
                                  icon: const Icon(Icons.delete, color: Colors.redAccent, size: 14),
                                  label: const Text('Hapus', style: TextStyle(color: Colors.redAccent, fontSize: 11)),
                                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.redAccent)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: '$title: ', style: const TextStyle(color: Colors.white38, fontSize: 11)),
            TextSpan(text: val, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  void _tampilkanDialogGenerasiAI(BuildContext context) {
    final TextEditingController promptController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF04140C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.greenAccent, width: 0.5)),
        title: const Text('Add Forest Decal', style: TextStyle(color: Colors.greenAccent, fontSize: 13)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: promptController, style: const TextStyle(color: Colors.white, fontSize: 11), decoration: const InputDecoration(labelText: 'AI Prompt')),
            TextField(controller: nameController, style: const TextStyle(color: Colors.white, fontSize: 11), decoration: const InputDecoration(labelText: 'Name')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel', style: TextStyle(color: Colors.white38))),
          ElevatedButton(
            onPressed: () {
              if (promptController.text.isEmpty) return;
              final newDecal = DesainDecal(
                id: 'DSN-${DateTime.now().millisecondsSinceEpoch}',
                nama: nameController.text.isEmpty ? 'Forest Design' : nameController.text,
                kategori: 'Earthy',
                motif: 'Organic',
                ukuran: '30 × 20 cm',
                format: 'PNG',
                resolusi: '300 dpi',
                desainer: 'Forest AI',
                tanggalBuat: '29 Jun 2026',
                status: 'Aktif',
                imageUrl: 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(promptController.text)}?width=512&height=512&nologo=true',
              );
              setState(() {
                _listDesain.insert(0, newDecal);
              });
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, foregroundColor: Colors.black87),
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }
}
