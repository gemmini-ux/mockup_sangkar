import 'package:flutter/material.dart';
import 'package:mocupsangkar/features/mockup01/data/dummy_db.dart';

class DesainPage extends StatelessWidget {
  const DesainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listDesain = DummyDb.desainDecal;

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
          // Header: size 16 (larger)
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
          // Subtext/Caption: size 10 (below 12)
          Text(
            'Koleksi ${listDesain.length} motif decal stiker terdaftar dalam sistem',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 20),

          // Grid Layout
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listDesain.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (context, index) {
              final d = listDesain[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF101B2D),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title: size 13 (larger)
                        Expanded(
                          child: Text(
                            d.nama,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Badge format file: size 10 (below 12)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.cyanAccent.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            d.format,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.cyanAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Detail: size 10 (below 12)
                    Text(
                      'Motif: ${d.motif} · Kategori: ${d.kategori}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white54,
                      ),
                    ),
                    const Spacer(),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Description text: size 12
                        Row(
                          children: [
                            const Icon(Icons.aspect_ratio, size: 14, color: Colors.white38),
                            const SizedBox(width: 4),
                            Text(
                              d.ukuran,
                              style: const TextStyle(fontSize: 11, color: Colors.white70),
                            ),
                          ],
                        ),
                        // Desainer name: size 10 (below 12)
                        Text(
                          '@${d.desainer}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white38,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

