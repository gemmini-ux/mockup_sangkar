import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup07/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup07/models/sangkar_models.dart';

class DesainPage extends StatefulWidget {
  const DesainPage({super.key});

  @override
  State<DesainPage> createState() => _DesainPageState();
}

class _DesainPageState extends State<DesainPage> {
  late List<DesainDecal> _listDesain;
  late Set<String> _expandedCategories;

  @override
  void initState() {
    super.initState();
    _listDesain = List.from(DummyDb.desainDecal);
    _expandedCategories = {'Abstract', 'Hewan'}; // default expanded categories
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
    // Group decals by category
    final Map<String, List<DesainDecal>> groupedDecals = {};
    for (var d in _listDesain) {
      groupedDecals.putIfAbsent(d.kategori, () => []).add(d);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF120202),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.15)),
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
                    'CRIMSON ACCORDION CATALOG',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent, letterSpacing: 1.5),
                  ),
                  SizedBox(height: 4),
                  Text('Categories collapsible accordion view', style: TextStyle(fontSize: 10, color: Colors.white30)),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _tampilkanDialogGenerasiAI(context),
                icon: const Icon(Icons.add, size: 14),
                label: const Text('AI Generator', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: groupedDecals.keys.map((kategori) {
                final decals = groupedDecals[kategori]!;
                final isExpanded = _expandedCategories.contains(kategori);

                return Card(
                  color: const Color(0xFF1A0606),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Colors.white10)),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('$kategori (${decals.length})', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13)),
                        trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: Colors.redAccent),
                        onTap: () {
                          setState(() {
                            if (isExpanded) {
                              _expandedCategories.remove(kategori);
                            } else {
                              _expandedCategories.add(kategori);
                            }
                          });
                        },
                      ),
                      if (isExpanded)
                        Container(
                          padding: const EdgeInsets.all(12),
                          color: Colors.black26,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: decals.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.0,
                            ),
                            itemBuilder: (context, idx) {
                              final d = decals[idx];
                              return GestureDetector(
                                onTap: () => _tampilkanDetailModal(context, d),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(image: NetworkImage(_getImageUrlForDesain(d)), fit: BoxFit.cover),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.black54,
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(d.nama, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  void _tampilkanDetailModal(BuildContext context, DesainDecal d) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A0606),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.redAccent, width: 0.5)),
        title: Text(d.nama, style: const TextStyle(color: Colors.redAccent, fontSize: 14)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(_getImageUrlForDesain(d), height: 180, fit: BoxFit.contain),
            const SizedBox(height: 12),
            Text('Kategori: ${d.kategori} · Motif: ${d.motif}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
            Text('Dimensi: ${d.ukuran} · Resolusi: ${d.resolusi}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
            Text('Format: ${d.format} · Desainer: ${d.desainer}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Tutup', style: TextStyle(color: Colors.white38))),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _listDesain.removeWhere((element) => element.id == d.id);
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
    final TextEditingController nameController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF120202),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.redAccent, width: 0.5)),
        title: const Text('Add Crimson Decal', style: TextStyle(color: Colors.redAccent, fontSize: 13)),
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
                nama: nameController.text.isEmpty ? 'Crimson Design' : nameController.text,
                kategori: 'Abstract',
                motif: 'Crimson Motif',
                ukuran: '30 × 20 cm',
                format: 'PNG',
                resolusi: '300 dpi',
                desainer: 'Crimson AI',
                tanggalBuat: '29 Jun 2026',
                status: 'Aktif',
                imageUrl: 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(promptController.text)}?width=512&height=512&nologo=true',
              );
              setState(() {
                _listDesain.insert(0, newDecal);
              });
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }
}
