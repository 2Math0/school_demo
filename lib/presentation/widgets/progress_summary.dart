import 'package:flutter/material.dart';

class ProgressSummary extends StatelessWidget {
  final Map<String, dynamic> stats;

  const ProgressSummary({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Learning Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Completed',
                  '${stats['completed_courses']}',
                  Icons.check_circle,
                ),
                _buildStatItem(
                  'In Progress',
                  '${stats['in_progress_courses']}',
                  Icons.timer,
                ),
                _buildStatItem(
                  'Overall',
                  '${(stats['overall_progress'] * 100).toStringAsFixed(1)}%',
                  Icons.trending_up,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
