import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: theme.iconTheme.color),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text("Tasks"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.textTheme.bodyLarge?.color,
        titleTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: theme.textTheme.titleLarge?.color,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Reward Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.monetization_on, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Text("You have earned: ",
                    style: theme.textTheme.bodyMedium),
                Text("₦1,200",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Daily Challenge
          Text("🔥 Daily Challenge",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 10),
          _buildTaskItem(
            context,
            title: "Top up ₦100 airtime",
            reward: "Earn ₦10",
            isCompleted: false,
            icon: Icons.phone_android,
          ),
          const SizedBox(height: 24),
          const Divider(),

          const SizedBox(height: 10),
          Text("📋 Other Tasks",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 10),
          _buildTaskItem(
            context,
            title: "Refer a Friend",
            reward: "Earn ₦100",
            isCompleted: true,
            icon: Icons.people_outline,
          ),
          const SizedBox(height: 10),
          _buildTaskItem(
            context,
            title: "Buy Data Bundle",
            reward: "Earn ₦20",
            isCompleted: false,
            icon: Icons.wifi,
          ),
          const SizedBox(height: 10),
          _buildTaskItem(
            context,
            title: "Pay a PHCN Bill",
            reward: "Earn ₦30",
            isCompleted: false,
            icon: Icons.lightbulb_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(
    BuildContext context, {
    required String title,
    required String reward,
    required bool isCompleted,
    required IconData icon,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      )),
                  Text(reward,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.green[600],
                      )),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.green.withOpacity(0.15)
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                isCompleted ? "Completed" : "In Progress",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isCompleted
                      ? Colors.green
                      : theme.colorScheme.onSurface,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
