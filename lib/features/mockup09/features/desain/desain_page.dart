import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup09/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup09/models/sangkar_models.dart';

class DesainPage extends StatefulWidget {
  const DesainPage({super.key});

  @override
  State<DesainPage> createState() => _DesainPageState();
}

class _DesainPageState extends State<DesainPage> {
  late List<DesainDecal> _listDesain;

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
        color: const Color(0xFF0D0D00),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.yellowAccent.withValues(alpha: 0.15)),
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
                    'CYBERPUNK DECAL SYSTEM',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.yellowAccent, letterSpacing: 1.5),
                  ),
                  SizedBox(height: 4),
                  Text('Industrial dark mode grid with overlay quick commands', style: TextStyle(fontSize: 10, color: Colors.yellowAccent)),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _tampilkanDialogGenerasiAI(context),
                icon: const Icon(Icons.flash_on, size: 14, color: Colors.black),
                label: const Text('CREATE W/ AI', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellowAccent,
                  shape: const BeveledRectangleBorder(),
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
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, idx) {
                final d = _listDesain[idx];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E02),
                    border: Border.all(color: Colors.yellowAccent.withValues(alpha: 0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Thumbnail Overlay Actions
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(_getImageUrlForDesain(d), fit: BoxFit.cover),
                            Container(
                              color: Colors.black38,
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.black.withValues(alpha: 0.6),
                                    child: IconButton(
                                      icon: const Icon(Icons.fullscreen, color: Colors.yellowAccent, size: 16),
                                      onPressed: () => _tampilkanLightbox(context, d),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.black.withValues(alpha: 0.6),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete_forever, color: Colors.redAccent, size: 16),
                                      onPressed: () {
                                        setState(() {
                                          _listDesain.removeAt(idx);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.black87,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                            const SizedBox(height: 2),
                            Text('CAT: ${d.kategori} | ID: ${d.id}', style: const TextStyle(color: Colors.yellowAccent, fontSize: 8)),
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

  void _tampilkanLightbox(BuildContext context, DesainDecal d) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D00),
            border: Border.all(color: Colors.yellowAccent),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(d.nama, style: const TextStyle(fontSize: 14, color: Colors.white)),
                leading: IconButton(icon: const Icon(Icons.close, color: Colors.yellowAccent), onPressed: () => Get.back()),
              ),
              Expanded(
                child: InteractiveViewer(
                  child: Image.network(_getImageUrlForDesain(d), fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tampilkanDialogGenerasiAI(BuildContext context) {
    final TextEditingController promptController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF0D0D00),
        shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.yellowAccent, width: 0.5)),
        title: const Text('Add Cyberpunk Decal', style: TextStyle(color: Colors.yellowAccent, fontSize: 13)),
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
                nama: nameController.text.isEmpty ? 'Cyberpunk Design' : nameController.text,
                kategori: 'Tech',
                motif: 'Cyber',
                ukuran: '30 × 20 cm',
                format: 'PNG',
                resolusi: '300 dpi',
                desainer: 'Cyber AI',
                tanggalBuat: '29 Jun 2026',
                status: 'Aktif',
                imageUrl: 'https://image.pollinations.ai/prompt/${Uri.encodeComponent(promptController.text)}?width=512&height=512&nologo=true',
              );
              setState(() {
                _listDesain.insert(0, newDecal);
              });
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.yellowAccent, foregroundColor: Colors.black),
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }
}
