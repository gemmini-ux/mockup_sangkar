import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup10/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup10/models/sangkar_models.dart';

class DesainPage extends StatefulWidget {
  const DesainPage({super.key});

  @override
  State<DesainPage> createState() => _DesainPageState();
}

class _DesainPageState extends State<DesainPage> {
  late List<DesainDecal> _listDesain;
  String _searchQuery = '';

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
    final filtered = _listDesain.where((d) => d.nama.toLowerCase().contains(_searchQuery.toLowerCase()) || d.kategori.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
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
                    'MONOCHROME DESIGN GLASS',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
                  ),
                  SizedBox(height: 4),
                  Text('Premium frosted glass layout with smart search filter', style: TextStyle(fontSize: 10, color: Colors.white54)),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () => _tampilkanDialogGenerasiAI(context),
                icon: const Icon(Icons.add, size: 14, color: Colors.white),
                label: const Text('Add Glass Motif', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Glassmorphic Search Bar
          TextField(
            style: const TextStyle(color: Colors.white, fontSize: 12),
            decoration: InputDecoration(
              hintText: 'Cari desain decal...',
              hintStyle: const TextStyle(color: Colors.white30),
              prefixIcon: const Icon(Icons.search, color: Colors.white30, size: 18),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.all(10),
            ),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
          const SizedBox(height: 20),

          // Grid Layout
          Expanded(
            child: GridView.builder(
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, idx) {
                final d = filtered[idx];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(_getImageUrlForDesain(d), fit: BoxFit.cover),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), shape: BoxShape.circle),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.white70, size: 18),
                                    onPressed: () {
                                      setState(() {
                                        _listDesain.removeWhere((element) => element.id == d.id);
                                      });
                                    },
                                    constraints: const BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                            const SizedBox(height: 2),
                            Text('${d.kategori} · ${d.ukuran}', style: const TextStyle(color: Colors.white30, fontSize: 9)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _tampilkanDialogGenerasiAI(BuildContext context) {
    final TextEditingController promptController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0C0D14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.white30, width: 0.5)),
        title: const Text('Add Glass Decal', style: TextStyle(color: Colors.white, fontSize: 13)),
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
                nama: nameController.text.isEmpty ? 'Glass Design' : nameController.text,
                kategori: 'Glassmorphic',
                motif: 'Frosted',
                ukuran: '30 × 20 cm',
                format: 'PNG',
                resolusi: '300 dpi',
                desainer: 'Glass AI',
                tanggalBuat: '29 Jun 2026',
                status: 'Aktif',
                imageUrl: 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(promptController.text)}?width=512&height=512&nologo=true',
              );
              setState(() {
                _listDesain.insert(0, newDecal);
              });
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }
}
