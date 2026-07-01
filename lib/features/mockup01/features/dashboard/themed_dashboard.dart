import 'package:flutter/material.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/dashboard.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/project_panel.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/activity_panel.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/schedule_panel.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/donut_chart_card.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/production_card.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/quick_access_card.dart';
import 'package:mocupsangkar/features/mockup01/features/dashboard/notification_card.dart';

class ThemedDashboard extends StatefulWidget {
  final String layoutType;
  final Color accentColor;
  final Color cardColor;
  final Color backgroundColor;
  final bool isLightTheme;

  const ThemedDashboard({
    super.key,
    required this.layoutType,
    required this.accentColor,
    required this.cardColor,
    required this.backgroundColor,
    this.isLightTheme = false,
  });

  @override
  State<ThemedDashboard> createState() => _ThemedDashboardState();
}

class _ThemedDashboardState extends State<ThemedDashboard> {
  // Used specifically by Mockup 05 Tabbed workflow
  int _dashboardSubTab = 0;

  @override
  Widget build(BuildContext context) {
    final double spacing = 16.0;

    switch (widget.layoutType) {
      case 'neon_purple': // MOCKUP 02 - SPLIT COLUMN LEFT FOCUS
        return _buildSplitColumnLayout(spacing);

      case 'clean_minimalist': // MOCKUP 03 - 3-COLUMN BENTO GRID
        return _buildThreeColumnBentoGrid(spacing);

      case 'retro_amber': // MOCKUP 04 - SCHEDULE & ACTION CENTRIC
        return _buildScheduleActionCentric(spacing);

      case 'oceanic_teal': // MOCKUP 05 - TABBED SUB-VIEWS WORKFLOW
        return _buildTabbedSubviewsWorkflow(spacing);

      case 'forest_green': // MOCKUP 06 - STAGGERED SIDEBAR CARDS
        return _buildStaggeredSidebarCards(spacing);

      case 'metallic_crimson': // MOCKUP 07 - LINEAR PIPELINE ROWS
        return _buildLinearPipelineRows(spacing);

      case 'sakura_pink': // MOCKUP 08 - MASONRY PERCENTAGE WRAP
        return _buildMasonryPercentageWrap(spacing);

      case 'cyberpunk_yellow': // MOCKUP 09 - CYBER TERMINAL GRID
        return _buildCyberTerminalGrid(spacing);

      case 'monochrome_glass': // MOCKUP 10 - FROSTED STACK ROWS
        return _buildFrostedStackRows(spacing);

      default: // DEFAULT FALLBACK (SINGLE COLUMN STACK)
        return Column(
          children: [
            const DashboardCard(),
            SizedBox(height: spacing),
            const ProjectPanel(),
            SizedBox(height: spacing),
            const ActivityPanel(),
          ],
        );
    }
  }

  // 1. MOCKUP 02 - Neon Purple (Split columns: Left Focus)
  Widget _buildSplitColumnLayout(double spacing) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            children: [
              const DashboardCard(),
              SizedBox(height: spacing),
              const ProductionCard(),
              SizedBox(height: spacing),
              const ProjectPanel(),
              SizedBox(height: spacing),
              const DonutChartCard(),
              SizedBox(height: spacing),
              const ActivityPanel(),
              SizedBox(height: spacing),
              const QuickAccessCard(),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  const DashboardCard(),
                  SizedBox(height: spacing),
                  const ProductionCard(),
                  SizedBox(height: spacing),
                  const ProjectPanel(),
                ],
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const DonutChartCard(),
                  SizedBox(height: spacing),
                  const ActivityPanel(),
                  SizedBox(height: spacing),
                  const QuickAccessCard(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // 2. MOCKUP 03 - Clean Minimalist (3-Column Bento Grid)
  Widget _buildThreeColumnBentoGrid(double spacing) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return Column(
            children: [
              const DashboardCard(),
              SizedBox(height: spacing),
              const ProjectPanel(),
              SizedBox(height: spacing),
              const ProductionCard(),
              SizedBox(height: spacing),
              const ActivityPanel(),
            ],
          );
        }
        return Column(
          children: [
            const DashboardCard(),
            SizedBox(height: spacing),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Col 1
                Expanded(
                  child: Column(
                    children: [
                      const ProjectPanel(),
                      SizedBox(height: spacing),
                      const DonutChartCard(),
                    ],
                  ),
                ),
                SizedBox(width: spacing),
                // Col 2
                Expanded(
                  child: Column(
                    children: [
                      const ProductionCard(),
                      SizedBox(height: spacing),
                      const QuickAccessCard(),
                    ],
                  ),
                ),
                SizedBox(width: spacing),
                // Col 3
                Expanded(
                  child: Column(
                    children: [
                      const ActivityPanel(),
                      SizedBox(height: spacing),
                      const NotificationCard(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // 3. MOCKUP 04 - Retro Amber (Schedule & Action Centric)
  Widget _buildScheduleActionCentric(double spacing) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            children: [
              const DashboardCard(),
              SizedBox(height: spacing),
              const SchedulePanel(),
              SizedBox(height: spacing),
              const QuickAccessCard(),
              SizedBox(height: spacing),
              const ProjectPanel(),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const SchedulePanel(),
                  SizedBox(height: spacing),
                  const QuickAccessCard(),
                  SizedBox(height: spacing),
                  const NotificationCard(),
                ],
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  const DashboardCard(),
                  SizedBox(height: spacing),
                  const ProjectPanel(),
                  SizedBox(height: spacing),
                  const DonutChartCard(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // 4. MOCKUP 05 - Oceanic Teal (Tabbed Dashboard Sections)
  Widget _buildTabbedSubviewsWorkflow(double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sub-Tab bar
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: widget.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              _buildSubTabButton('Utama', 0),
              _buildSubTabButton('Produksi & Log', 1),
              _buildSubTabButton('Aksi & Pesan', 2),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Active Sub-Tab View
        _dashboardSubTab == 0
            ? Column(
                children: [
                  const DashboardCard(),
                  SizedBox(height: spacing),
                  const ProductionCard(),
                  SizedBox(height: spacing),
                  const DonutChartCard(),
                ],
              )
            : _dashboardSubTab == 1
                ? Column(
                    children: [
                      const ProjectPanel(),
                      SizedBox(height: spacing),
                      const ActivityPanel(),
                      SizedBox(height: spacing),
                      const SchedulePanel(),
                    ],
                  )
                : Column(
                    children: [
                      const QuickAccessCard(),
                      SizedBox(height: spacing),
                      const NotificationCard(),
                    ],
                  ),
      ],
    );
  }

  Widget _buildSubTabButton(String label, int index) {
    final isSel = _dashboardSubTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _dashboardSubTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSel ? widget.accentColor.withValues(alpha: 0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isSel ? widget.accentColor : (widget.isLightTheme ? Colors.black54 : Colors.white54),
            ),
          ),
        ),
      ),
    );
  }

  // 5. MOCKUP 06 - Forest Green (Staggered Sidebar Cards)
  Widget _buildStaggeredSidebarCards(double spacing) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            children: [
              const DashboardCard(),
              SizedBox(height: spacing),
              const SchedulePanel(),
              SizedBox(height: spacing),
              const ProjectPanel(),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  const DashboardCard(),
                  SizedBox(height: spacing),
                  const ActivityPanel(),
                  SizedBox(height: spacing),
                  const DonutChartCard(),
                ],
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  const SchedulePanel(),
                  SizedBox(height: spacing),
                  const ProjectPanel(),
                  SizedBox(height: spacing),
                  const QuickAccessCard(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // 6. MOCKUP 07 - Metallic Crimson (Linear Pipeline Rows)
  Widget _buildLinearPipelineRows(double spacing) {
    return Column(
      children: [
        const DashboardCard(),
        SizedBox(height: spacing),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 650) {
              return Column(
                children: [
                  const ProductionCard(),
                  SizedBox(height: spacing),
                  const DonutChartCard(),
                ],
              );
            }
            return Row(
              children: [
                const Expanded(child: ProductionCard()),
                SizedBox(width: spacing),
                const Expanded(child: DonutChartCard()),
              ],
            );
          },
        ),
        SizedBox(height: spacing),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 750) {
              return Column(
                children: [
                  const ProjectPanel(),
                  SizedBox(height: spacing),
                  const NotificationCard(),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 3, child: ProjectPanel()),
                SizedBox(width: spacing),
                const Expanded(flex: 2, child: NotificationCard()),
              ],
            );
          },
        ),
      ],
    );
  }

  // 7. MOCKUP 08 - Sakura Pink (Masonry Percentage Wrap)
  Widget _buildMasonryPercentageWrap(double spacing) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        if (w < 800) {
          return Column(
            children: [
              const DashboardCard(),
              SizedBox(height: spacing),
              const DonutChartCard(),
              SizedBox(height: spacing),
              const ProjectPanel(),
              SizedBox(height: spacing),
              const QuickAccessCard(),
            ],
          );
        }
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            SizedBox(
              width: w,
              child: const DashboardCard(),
            ),
            SizedBox(
              width: w * 0.38 - (spacing / 2),
              child: const DonutChartCard(),
            ),
            SizedBox(
              width: w * 0.62 - (spacing / 2),
              child: const ProjectPanel(),
            ),
            SizedBox(
              width: w * 0.48 - (spacing / 2),
              child: const QuickAccessCard(),
            ),
            SizedBox(
              width: w * 0.52 - (spacing / 2),
              child: const ActivityPanel(),
            ),
          ],
        );
      },
    );
  }

  // 8. MOCKUP 09 - Cyberpunk Yellow (Cyber Terminal Grid)
  Widget _buildCyberTerminalGrid(double spacing) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 850) {
          return Column(
            children: [
              const QuickAccessCard(),
              SizedBox(height: spacing),
              const DashboardCard(),
              SizedBox(height: spacing),
              const ProductionCard(),
              SizedBox(height: spacing),
              const SchedulePanel(),
            ],
          );
        }
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 2, child: QuickAccessCard()),
                SizedBox(width: spacing),
                const Expanded(flex: 3, child: DashboardCard()),
              ],
            ),
            SizedBox(height: spacing),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 3, child: ProductionCard()),
                SizedBox(width: spacing),
                const Expanded(flex: 2, child: SchedulePanel()),
              ],
            ),
            SizedBox(height: spacing),
            const ActivityPanel(),
          ],
        );
      },
    );
  }

  // 9. MOCKUP 10 - Monochrome Glass (Frosted Stack Rows)
  Widget _buildFrostedStackRows(double spacing) {
    return Column(
      children: [
        const DashboardCard(),
        SizedBox(height: spacing),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 650) {
              return Column(
                children: [
                  const DonutChartCard(),
                  SizedBox(height: spacing),
                  const ProductionCard(),
                ],
              );
            }
            return Row(
              children: [
                const Expanded(child: DonutChartCard()),
                SizedBox(width: spacing),
                const Expanded(child: ProductionCard()),
              ],
            );
          },
        ),
        SizedBox(height: spacing),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 700) {
              return Column(
                children: [
                  const ProjectPanel(),
                  SizedBox(height: spacing),
                  const ActivityPanel(),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: ProjectPanel()),
                SizedBox(width: spacing),
                const Expanded(child: ActivityPanel()),
              ],
            );
          },
        ),
      ],
    );
  }
}
