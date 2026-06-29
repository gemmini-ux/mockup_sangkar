import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup04/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup04/models/sangkar_models.dart';

class DesainPage extends StatefulWidget {
  const DesainPage({super.key});

  @override
  State<DesainPage> createState() => _DesainPageState();
}

class _DesainPageState extends State<DesainPage> {
  late List<DesainDecal> _listDesain;
  int _activeIdx = 0;
  final PageController _pageController = PageController(viewportFraction: 0.6);

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
    final bool hasData = _listDesain.isNotEmpty;
    if (_activeIdx >= _listDesain.length) {
      _activeIdx = 0;
    }
    final activeDecal = hasData ? _listDesain[_activeIdx] : null;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D140A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
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
                    'RETRO DECAL SWIPER',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber, letterSpacing: 1.5),
                  ),
                  SizedBox(height: 4),
                  Text('Horizontal carousel browser & details sheet', style: TextStyle(fontSize: 10, color: Colors.white54)),
                ],
              ),
              ElevatedButton(
                onPressed: () => _tampilkanAIGenerator(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: const Color(0xFF1D140A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: const Text('AI Generative', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (!hasData)
            const Expanded(child: Center(child: Text('Tidak ada stiker decal.', style: TextStyle(color: Colors.amber))))
          else ...[
            // Swiper PageView
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _listDesain.length,
                onPageChanged: (val) => setState(() => _activeIdx = val),
                itemBuilder: (context, idx) {
                  final d = _listDesain[idx];
                  final isFocused = idx == _activeIdx;
                  return AnimatedScale(
                    scale: isFocused ? 1.0 : 0.82,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isFocused ? Colors.amber : Colors.white10, width: isFocused ? 2 : 1),
                        image: DecorationImage(image: NetworkImage(_getImageUrlForDesain(d)), fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Detail Panel below carousel
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF130B05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.1)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(activeDecal!.nama, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.amber)),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent, size: 18),
                            onPressed: () {
                              setState(() {
                                _listDesain.removeAt(_activeIdx);
                                if (_activeIdx >= _listDesain.length && _listDesain.isNotEmpty) {
                                  _activeIdx = _listDesain.length - 1;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow('ID', activeDecal.id),
                      _buildInfoRow('Kategori', activeDecal.kategori),
                      _buildInfoRow('Motif', activeDecal.motif),
                      _buildInfoRow('Ukuran', activeDecal.ukuran),
                      _buildInfoRow('Format', activeDecal.format),
                      _buildInfoRow('Desainer', activeDecal.desainer),
                    ],
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white30, fontSize: 11))),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.white70, fontSize: 11))),
        ],
      ),
    );
  }

  void _tampilkanAIGenerator(BuildContext context) {
    final TextEditingController promptController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1D140A),
        title: const Text('Retro AI Generator', style: TextStyle(color: Colors.amber, fontSize: 13)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: promptController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: 'Prompt')),
            TextField(controller: nameController, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: 'Name')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel', style: TextStyle(color: Colors.white38))),
          ElevatedButton(
            onPressed: () {
              if (promptController.text.isEmpty) return;
              final newDecal = DesainDecal(
                id: 'DSN-${DateTime.now().millisecondsSinceEpoch}',
                nama: nameController.text.isEmpty ? 'Retro Design' : nameController.text,
                kategori: 'Retro',
                motif: 'Classic',
                ukuran: '30 × 20 cm',
                format: 'PNG',
                resolusi: '300 dpi',
                desainer: 'Retro AI',
                tanggalBuat: '29 Jun 2026',
                status: 'Aktif',
                imageUrl: 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(promptController.text)}?width=512&height=512&nologo=true',
              );
              setState(() {
                _listDesain.insert(0, newDecal);
                _activeIdx = 0;
              });
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
