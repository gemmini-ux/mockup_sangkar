import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/mockup01/homepage_mc01.dart';
import 'features/mockup05/homepage_mc05.dart';
import 'features/mockup06/homepage_mc06.dart';
import 'features/mockup07/homepage_mc07.dart';
import 'features/mockup08/homepage_mc08.dart';
import 'features/mockup09/homepage_mc09.dart';
import 'features/mockup10/homepage_mc10.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mockups = List.generate(
      10,
      (index) => 'Mockup Sangkar ${(index + 1).toString().padLeft(2, '0')}',
    );

    final pages = [
      const HomePageMc01(),  // 01 — Cyber Dark Blue    ✅ Lengkap
      const HomePageMc01(),  // 02 — Neon Purple         🔲 Coming Soon
      const HomePageMc01(),  // 03 — Clean Minimalist    🔲 Coming Soon
      const HomePageMc01(),  // 04 — Retro Amber         🔲 Coming Soon
      const HomePageMc05(),  // 05 — Oceanic Teal        🔲 Placeholder
      const HomePageMc06(),  // 06 — Forest Green        🔲 Placeholder
      const HomePageMc07(),  // 07 — Metallic Crimson    🔲 Placeholder
      const HomePageMc08(),  // 08 — Sakura Pink         🔲 Placeholder
      const HomePageMc09(),  // 09 — Cyberpunk Yellow    🔲 Placeholder
      const HomePageMc10(),  // 10 — Monochrome Glass    🔲 Placeholder
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF050816),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: const Text(
          'Mockup Sangkar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          itemCount: mockups.length,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 2.2,
          ),

          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(16),

              onTap: () {
                Get.to(
                  () => pages[index],
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 300),
                );
              },

              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(
                    color: Colors.blueAccent.withValues(alpha: 0.3),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withValues(alpha: 0.1),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.dashboard_customize_rounded,
                      size: 42,
                      color: Colors.cyanAccent.shade100,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      mockups[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Layout ${index + 1}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
