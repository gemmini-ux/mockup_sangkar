// ============================================================
// SIDEBAR RESPONSIVE — Versi Desktop (280px) & Tablet (72px ikon)
// ============================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocupsangkar/homepage.dart';

class SidebarDesktop extends StatelessWidget {
  final int menuAktif;
  final ValueChanged<int> onMenuTap;

  const SidebarDesktop({
    super.key,
    required this.menuAktif,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final menus = _menus();

    return Container(
      width: 260,
      decoration: const BoxDecoration(
        color: Color(0xFF07101F),
        border: Border(right: BorderSide(color: Color(0xFF16253C))),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // ── LOGO ─────────────────────────────────────────
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF101B2D),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent.withValues(alpha: .15),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.cyanAccent.withValues(alpha: .5)),
                  ),
                  child: const Icon(Icons.auto_fix_high, color: Colors.cyanAccent, size: 22),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SANGKAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        'Studio Decal',
                        style: TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'MENU UTAMA',
              style: TextStyle(
                color: Colors.white.withValues(alpha: .3),
                fontSize: 10,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 6),

          // ── MENU LIST ────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: menus.length,
              itemBuilder: (context, i) {
                final m = menus[i];
                final aktif = i == menuAktif;
                return _MenuTile(
                  icon: m.$1,
                  label: m.$2,
                  aktif: aktif,
                  onTap: () => onMenuTap(i),
                );
              },
            ),
          ),

          const Divider(color: Colors.white12, height: 1),

          // ── USER FOOTER ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.cyanAccent, Colors.blue],
                    ),
                  ),
                  child: const Icon(Icons.person, color: Colors.black, size: 20),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin Produksi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Professional Edition',
                        style: TextStyle(color: Colors.white54, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout_outlined, color: Colors.white30, size: 18),
                  hoverColor: Colors.redAccent.withValues(alpha: 0.1),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () => _logout(context),
                  tooltip: 'Keluar',
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sidebar Mini (Tablet, ikon saja 72px) ─────────────────────
class SidebarTablet extends StatelessWidget {
  final int menuAktif;
  final ValueChanged<int> onMenuTap;

  const SidebarTablet({
    super.key,
    required this.menuAktif,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final menus = _menus();

    return Container(
      width: 72,
      decoration: const BoxDecoration(
        color: Color(0xFF07101F),
        border: Border(right: BorderSide(color: Color(0xFF16253C))),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Logo mini
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withValues(alpha: .15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.cyanAccent.withValues(alpha: .5)),
            ),
            child: const Icon(Icons.auto_fix_high, color: Colors.cyanAccent, size: 20),
          ),

          const SizedBox(height: 16),
          Container(height: 1, color: Colors.white10),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: menus.length,
              itemBuilder: (context, i) {
                final m = menus[i];
                final aktif = i == menuAktif;
                return Tooltip(
                  message: m.$2,
                  preferBelow: false,
                  child: InkWell(
                    onTap: () => onMenuTap(i),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: aktif
                            ? Colors.cyanAccent.withValues(alpha: .15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        m.$1,
                        color: aktif ? Colors.cyanAccent : Colors.white38,
                        size: 22,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Colors.cyanAccent, Colors.blue]),
            ),
            child: const Icon(Icons.person, color: Colors.black, size: 20),
          ),
          const SizedBox(height: 12),
          Tooltip(
            message: 'Keluar',
            preferBelow: false,
            child: InkWell(
              onTap: () => _logout(context),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.logout_outlined, color: Colors.white30, size: 18),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Drawer Sidebar (Mobile) ────────────────────────────────────
class DrawerMobile extends StatelessWidget {
  final int menuAktif;
  final ValueChanged<int> onMenuTap;

  const DrawerMobile({
    super.key,
    required this.menuAktif,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final menus = _menus();

    return Drawer(
      backgroundColor: const Color(0xFF07101F),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF101B2D),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.withValues(alpha: .15),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.cyanAccent.withValues(alpha: .5)),
                    ),
                    child: const Icon(Icons.auto_fix_high, color: Colors.cyanAccent),
                  ),
                  const SizedBox(width: 14),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SANGKAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        'Studio Decal',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white38),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                itemCount: menus.length,
                itemBuilder: (context, i) {
                  final m = menus[i];
                  final aktif = i == menuAktif;
                  return _MenuTile(
                    icon: m.$1,
                    label: m.$2,
                    aktif: aktif,
                    onTap: () {
                      Navigator.of(context).pop();
                      onMenuTap(i);
                    },
                  );
                },
              ),
            ),

            const Divider(color: Colors.white12, height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [Colors.cyanAccent, Colors.blue]),
                    ),
                    child: const Icon(Icons.person, color: Colors.black, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin Produksi',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Professional Edition',
                          style: TextStyle(color: Colors.white54, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout_outlined, color: Colors.white30, size: 18),
                    onPressed: () => _logout(context),
                    tooltip: 'Keluar',
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Tile item menu reusable ────────────────────────────────────
class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool aktif;
  final VoidCallback onTap;

  const _MenuTile({
    required this.icon,
    required this.label,
    required this.aktif,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: aktif ? Colors.cyanAccent.withValues(alpha: .12) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: aktif
            ? Border.all(color: Colors.cyanAccent.withValues(alpha: .2))
            : Border.all(color: Colors.transparent),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          size: 20,
          color: aktif ? Colors.cyanAccent : Colors.white38,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: aktif ? Colors.cyanAccent : Colors.white60,
            fontSize: 12,
            fontWeight: aktif ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        trailing: aktif
            ? Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(4),
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}

// ── Daftar menu ───────────────────────────────────────────────
List<(IconData, String)> _menus() => [
  (Icons.dashboard_outlined,              'Dashboard'),
  (Icons.list_alt_rounded,               'Data Sangkar'),
  (Icons.grid_view_rounded,              'Template'),
  (Icons.draw_outlined,                  'Desain'),
  (Icons.palette_outlined,               'Tema & Style'),
  (Icons.auto_awesome_outlined,          'Ornamen'),
  (Icons.extension_outlined,             'Komponen'),
  (Icons.smart_toy_outlined,             'AI Prompt'),
  (Icons.map_outlined,                   'Mapping Editor'),
  (Icons.view_in_ar_outlined,            'Preview 3D'),
  (Icons.precision_manufacturing_outlined,'Produksi'),
  (Icons.shopping_cart_outlined,         'Pesanan'),
  (Icons.people_outline,                 'Pelanggan'),
  (Icons.bar_chart_outlined,             'Laporan'),
  (Icons.settings_outlined,              'Pengaturan'),
];

void _logout(BuildContext context) {
  Get.dialog(
    AlertDialog(
      backgroundColor: const Color(0xFF0C0A19),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.cyanAccent, width: 0.5),
      ),
      title: const Row(
        children: [
          Icon(Icons.logout_rounded, color: Colors.cyanAccent, size: 20),
          SizedBox(width: 8),
          Text(
            'KELUAR APLIKASI?',
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'Apakah Anda yakin ingin keluar dan kembali ke halaman utama pemilihan mockup?',
        style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.5),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Batal', style: TextStyle(color: Colors.white38, fontSize: 11)),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(); // close dialog
            Get.offAll(
              () => const HomePage(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 300),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyanAccent,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: const Text('Keluar', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

