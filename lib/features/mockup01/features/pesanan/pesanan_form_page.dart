import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/features/mockup01/data/dummy_db.dart';
import 'package:mocupsangkar/features/mockup01/controllers/order_controller.dart';
import 'package:mocupsangkar/features/mockup01/models/sangkar_models.dart';

class PesananFormPage extends StatefulWidget {
  final Pesanan? order;
  final TemplateSangkar? template;
  const PesananFormPage({super.key, this.order, this.template});

  @override
  State<PesananFormPage> createState() => _PesananFormPageState();
}

class _PesananFormPageState extends State<PesananFormPage> {
  final OrderController controller = Get.find<OrderController>();
  final _formKey = GlobalKey<FormState>();

  // State fields
  late String _selectedPelangganId;
  late String _selectedPelangganNama;
  late String _selectedSangkarId;
  late String _selectedSangkarNama;
  late String _selectedSangkarBentuk;
  late String _selectedMotif;
  late List<String> _selectedBagian;
  late int _qty;
  late String _ukuranKhusus;
  late String _catatan;
  late DateTime _deadline;

  List<BagianSangkar> _bagianTersedia = [];

  @override
  void initState() {
    super.initState();
    final isEdit = widget.order != null;

    if (isEdit) {
      final o = widget.order!;
      _selectedPelangganId = o.pelangganId;
      _selectedPelangganNama = o.pelangganNama;
      
      // Find matching sangkar from DummyDb
      final jSangkar = DummyDb.jenisSangkar.firstWhere(
        (s) => s.nama == o.jenisSangkar,
        orElse: () => DummyDb.jenisSangkar.first,
      );
      _selectedSangkarId = jSangkar.id;
      _selectedSangkarNama = jSangkar.nama;
      _selectedSangkarBentuk = jSangkar.bentuk;
      _bagianTersedia = jSangkar.bagian;

      _selectedMotif = o.motifDecal;
      _selectedBagian = List<String>.from(o.bagianDecal);
      _qty = o.qty;
      _ukuranKhusus = o.ukuranKhusus;
      _catatan = o.catatan;
      // Parse date
      try {
        _deadline = DateTime.parse(o.deadline.split(' · ').first);
      } catch (e) {
        _deadline = DateTime.now().add(const Duration(days: 7));
      }
    } else if (widget.template != null) {
      final t = widget.template!;
      _selectedPelangganId = DummyDb.pelanggan.first.id;
      _selectedPelangganNama = DummyDb.pelanggan.first.nama;

      final jSangkar = DummyDb.jenisSangkar.firstWhere(
        (s) => s.id == t.jenisSangkarId,
        orElse: () => DummyDb.jenisSangkar.first,
      );
      _selectedSangkarId = jSangkar.id;
      _selectedSangkarNama = jSangkar.nama;
      _selectedSangkarBentuk = jSangkar.bentuk;
      _bagianTersedia = jSangkar.bagian;

      // Find motif of first decal
      final firstDecalId = t.desainDecalIds.isNotEmpty ? t.desainDecalIds.first : '';
      final decal = DummyDb.desainDecal.firstWhere(
        (d) => d.id == firstDecalId,
        orElse: () => DummyDb.desainDecal.first,
      );
      _selectedMotif = decal.motif;

      // Select all parts where perluDecal is true
      _selectedBagian = jSangkar.bagian
          .where((b) => b.perluDecal)
          .map((b) => b.nama)
          .toList();

      _qty = 1;
      _ukuranKhusus = '';
      _catatan = 'Dibuat dari templat preset: ${t.nama}';
      _deadline = DateTime.now().add(const Duration(days: 7));
    } else {
      // Default initial states
      _selectedPelangganId = DummyDb.pelanggan.first.id;
      _selectedPelangganNama = DummyDb.pelanggan.first.nama;

      final jSangkar = DummyDb.jenisSangkar.first;
      _selectedSangkarId = jSangkar.id;
      _selectedSangkarNama = jSangkar.nama;
      _selectedSangkarBentuk = jSangkar.bentuk;
      _bagianTersedia = jSangkar.bagian;

      _selectedMotif = DummyDb.desainDecal.first.motif;
      _selectedBagian = [];
      _qty = 1;
      _ukuranKhusus = '';
      _catatan = '';
      _deadline = DateTime.now().add(const Duration(days: 7));
    }
  }

  void _onSangkarChanged(String id) {
    final js = DummyDb.jenisSangkar.firstWhere((s) => s.id == id);
    setState(() {
      _selectedSangkarId = js.id;
      _selectedSangkarNama = js.nama;
      _selectedSangkarBentuk = js.bentuk;
      _bagianTersedia = js.bagian;
      _selectedBagian.clear(); // Reset selections
    });
  }

  void _simpanForm() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedBagian.isEmpty) {
      Get.snackbar(
        'PERINGATAN',
        'Pilih minimal satu bagian sangkar untuk decal stiker!',
        backgroundColor: const Color(0xFF0C0A19),
        colorText: Colors.orangeAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final isEdit = widget.order != null;
    final totalCalculatedPrice = 'Rp ${(_qty * 150000).toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';

    final deadlineString = '${_deadline.toIso8601String().substring(0, 10)} · Sisa ${Get.find<OrderController>().orders.length + 3} Hari';

    if (isEdit) {
      final old = widget.order!;
      // Update by removing and inserting new
      controller.deleteOrder(old.id);
      controller.addOrder(Pesanan(
        id: old.id,
        kode: old.kode,
        pelangganId: _selectedPelangganId,
        pelangganNama: _selectedPelangganNama,
        jenisSangkar: _selectedSangkarNama,
        bentukSangkar: _selectedSangkarBentuk,
        motifDecal: _selectedMotif,
        bagianDecal: _selectedBagian,
        qty: _qty,
        ukuranKhusus: _ukuranKhusus,
        catatan: _catatan,
        deadline: deadlineString,
        statusProduksi: old.statusProduksi,
        statusPembayaran: old.statusPembayaran,
        totalHarga: totalCalculatedPrice,
        tanggalPesan: old.tanggalPesan,
      ));
      Get.back();
      Get.snackbar('SUKSES', 'Pesanan ${old.kode} berhasil diperbarui',
          backgroundColor: const Color(0xFF101B2D),
          colorText: Colors.greenAccent,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      final orderCode = 'SGK-${(controller.orders.length + 1).toString().padLeft(3, '0')}';
      controller.addOrder(Pesanan(
        id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
        kode: orderCode,
        pelangganId: _selectedPelangganId,
        pelangganNama: _selectedPelangganNama,
        jenisSangkar: _selectedSangkarNama,
        bentukSangkar: _selectedSangkarBentuk,
        motifDecal: _selectedMotif,
        bagianDecal: _selectedBagian,
        qty: _qty,
        ukuranKhusus: _ukuranKhusus,
        catatan: _catatan,
        deadline: deadlineString,
        statusProduksi: 'Desain',
        statusPembayaran: 'DP',
        totalHarga: totalCalculatedPrice,
        tanggalPesan: DateTime.now().toLocal().toString().substring(0, 10),
      ));
      Get.back();
      Get.snackbar('SUKSES', 'Pesanan baru $orderCode berhasil dicatat',
          backgroundColor: const Color(0xFF101B2D),
          colorText: Colors.greenAccent,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.order != null;

    return Scaffold(
      backgroundColor: const Color(0xFF06050C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0A19),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.cyanAccent),
          onPressed: () => Get.back(),
        ),
        title: Text(
          isEdit ? 'EDIT PESANAN STIKER' : 'TAMBAH PESANAN BARU',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form card container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C0A19),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title: size 14 (larger)
                    const Text(
                      'INFORMASI PELANGGAN & SANGKAR',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
                    ),
                    const Divider(color: Colors.white12, height: 20),

                    // Pelanggan Dropdown
                    _buildLabel('Pelanggan'),
                    DropdownButtonFormField<String>(
                      dropdownColor: const Color(0xFF101B2D),
                      initialValue: _selectedPelangganId,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      decoration: _inputDecoration(),
                      items: DummyDb.pelanggan.map((p) {
                        return DropdownMenuItem(
                          value: p.id,
                          child: Text('${p.nama} (${p.kota})'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          final selected = DummyDb.pelanggan.firstWhere((p) => p.id == val);
                          setState(() {
                            _selectedPelangganId = selected.id;
                            _selectedPelangganNama = selected.nama;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Jenis Sangkar Dropdown
                    _buildLabel('Jenis & Bentuk Sangkar'),
                    DropdownButtonFormField<String>(
                      dropdownColor: const Color(0xFF101B2D),
                      initialValue: _selectedSangkarId,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      decoration: _inputDecoration(),
                      items: DummyDb.jenisSangkar.map((s) {
                        return DropdownMenuItem(
                          value: s.id,
                          child: Text('${s.nama} [${s.bentuk} - ${s.ukuranTotal}]'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          _onSangkarChanged(val);
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Motif Decal Dropdown
                    _buildLabel('Motif Stiker Decal'),
                    DropdownButtonFormField<String>(
                      dropdownColor: const Color(0xFF101B2D),
                      initialValue: _selectedMotif,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      decoration: _inputDecoration(),
                      items: DummyDb.desainDecal.map((d) {
                        return DropdownMenuItem(
                          value: d.motif,
                          child: Text('${d.nama} (${d.kategori} - ${d.format})'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedMotif = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 24),

                    // Checklist Bagian Sangkar
                    const Text(
                      'BAGIAN SANGKAR (DECAL SELECTION)',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
                    ),
                    const Divider(color: Colors.white12, height: 20),
                    // Note/Subtext: size 10 (below 12)
                    const Text(
                      '*Pilih bagian sangkar yang akan ditempeli decal stiker (Ukuran area pas mengikuti sistem database)',
                      style: TextStyle(fontSize: 10, color: Colors.white38),
                    ),
                    const SizedBox(height: 10),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _bagianTersedia.length,
                      itemBuilder: (context, i) {
                        final bg = _bagianTersedia[i];
                        final isSelected = _selectedBagian.contains(bg.nama);
                        return CheckboxListTile(
                          dense: true,
                          activeColor: Colors.cyanAccent,
                          checkColor: Colors.black,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            bg.nama,
                            style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          // Size subtext: size 10 (below 12)
                          subtitle: Text(
                            'Area: ${bg.ukuran} · Bentuk: ${bg.bentukArea} · Perlu Decal: ${bg.perluDecal ? 'YA' : 'TIDAK'}',
                            style: TextStyle(fontSize: 10, color: bg.perluDecal ? Colors.white38 : Colors.redAccent.withValues(alpha: 0.6)),
                          ),
                          value: isSelected,
                          onChanged: (val) {
                            setState(() {
                              if (val == true) {
                                _selectedBagian.add(bg.nama);
                              } else {
                                _selectedBagian.remove(bg.nama);
                              }
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Details
                    const Text(
                      'DETAIL PESANAN & DEADLINE',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
                    ),
                    const Divider(color: Colors.white12, height: 20),

                    Row(
                      children: [
                        // Quantity
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Jumlah Unit (Qty)'),
                              TextFormField(
                                initialValue: _qty.toString(),
                                style: const TextStyle(fontSize: 12, color: Colors.white),
                                keyboardType: TextInputType.number,
                                decoration: _inputDecoration(hint: 'Contoh: 5'),
                                validator: (val) {
                                  if (val == null || val.isEmpty) return 'Kuantitas wajib diisi';
                                  if (int.tryParse(val) == null || int.parse(val) <= 0) return 'Kuantitas harus berupa angka > 0';
                                  return null;
                                },
                                onChanged: (val) {
                                  final num = int.tryParse(val);
                                  if (num != null && num > 0) {
                                    setState(() {
                                      _qty = num;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Deadline Date selection
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Deadline Produksi'),
                              InkWell(
                                onTap: () async {
                                  final selected = await showDatePicker(
                                    context: context,
                                    initialDate: _deadline,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(const Duration(days: 365)),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.dark(
                                            primary: Colors.cyanAccent,
                                            onPrimary: Colors.black,
                                            surface: Color(0xFF0C0A19),
                                            onSurface: Colors.white,
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (selected != null) {
                                    setState(() {
                                      _deadline = selected;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF101B2D),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _deadline.toIso8601String().substring(0, 10),
                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                      const Icon(Icons.calendar_month, color: Colors.cyanAccent, size: 18),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Ukuran khusus & Catatan
                    _buildLabel('Ukuran Khusus (Opsional)'),
                    TextFormField(
                      initialValue: _ukuranKhusus,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                      decoration: _inputDecoration(hint: 'Misal: Lebar kubah diperpendek 2cm'),
                      onChanged: (val) => _ukuranKhusus = val,
                    ),
                    const SizedBox(height: 16),

                    _buildLabel('Catatan Pengerjaan (Desain/Mesin)'),
                    TextFormField(
                      initialValue: _catatan,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                      decoration: _inputDecoration(hint: 'Misal: Gunakan laminating glossy, kontur stiker dibulatkan'),
                      onChanged: (val) => _catatan = val,
                    ),
                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('BATAL', style: TextStyle(color: Colors.white38, fontSize: 12)),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: _simpanForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Text(
                            isEdit ? 'PERBARUI PESANAN' : 'CATAT PESANAN',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      // Form label size: 12
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.bold),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white30, fontSize: 12),
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
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    );
  }
}

