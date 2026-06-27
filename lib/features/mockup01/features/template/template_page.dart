import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup01/features/pesanan/pesanan_form_page.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  String _searchQuery = '';
  String _statusFilter = 'Semua';

  @override
  Widget build(BuildContext context) {
    final listTemplate = DummyDb.template;

    // Filter templates based on queries
    final filteredTemplates = listTemplate.where((t) {
      final matchSearch = t.nama.toLowerCase().contains(_searchQuery);
      final matchFilter = _statusFilter == 'Semua' || t.status == _statusFilter;
      return matchSearch && matchFilter;
    }).toList();

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
            'BLUEPRINT & TEMPLATE SANGKAR',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          // Caption: size 10 (below 12)
          const Text(
            'Daftar preset desain kombinasi stiker decal untuk tipe sangkar standar siap cetak',
            style: TextStyle(
              fontSize: 10,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 20),

          // Search and Filter Row
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Cari nama preset template...',
                    hintStyle: const TextStyle(color: Colors.white30, fontSize: 12),
                    prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent, size: 18),
                    filled: true,
                    fillColor: const Color(0xFF101B2D),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.cyan.withValues(alpha: 0.15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.cyanAccent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val.toLowerCase();
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Dropdown Filter: size 12
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF101B2D),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: const Color(0xFF101B2D),
                    value: _statusFilter,
                    icon: const Icon(Icons.filter_list, color: Colors.cyanAccent, size: 18),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    items: ['Semua', 'Aktif', 'Draft'].map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _statusFilter = val;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Grid Layout
          filteredTemplates.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      'Tidak ada preset template ditemukan.',
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredTemplates.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.45,
                  ),
                  itemBuilder: (context, index) {
                    final t = filteredTemplates[index];

                    // Find matching birdcage type
                    final sangkar = DummyDb.jenisSangkar.firstWhere(
                      (s) => s.id == t.jenisSangkarId,
                      orElse: () => DummyDb.jenisSangkar.first,
                    );

                    final isAktif = t.status == 'Aktif';

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
                              // Status pill: size 9 (below 12)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isAktif ? Colors.green.withValues(alpha: 0.15) : Colors.orange.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: isAktif ? Colors.greenAccent.withValues(alpha: 0.3) : Colors.orangeAccent.withValues(alpha: 0.3)),
                                ),
                                child: Text(
                                  t.status.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: isAktif ? Colors.greenAccent : Colors.orangeAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Popularity: size 10 (below 12)
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 12),
                                  const SizedBox(width: 2),
                                  Text(
                                    '${t.popularitas}%',
                                    style: const TextStyle(fontSize: 10, color: Colors.white70, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Preset Title: size 13 (larger)
                          Text(
                            t.nama,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Detail/Shape: size 10 (below 12)
                          Text(
                            'Tipe: ${sangkar.nama} (${sangkar.bentuk})',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white54,
                            ),
                          ),
                          const Spacer(),
                          const Divider(color: Colors.white10, height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Price: size 12
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('ESTIMASI BIAYA', style: TextStyle(fontSize: 8, color: Colors.white30)),
                                  Text(
                                    t.harga,
                                    style: const TextStyle(fontSize: 12, color: Colors.greenAccent, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              // Trigger button: size 10 (below 12)
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                    () => PesananFormPage(template: t),
                                    transition: Transition.fadeIn,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyanAccent,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'GUNAKAN PRESET',
                                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
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
