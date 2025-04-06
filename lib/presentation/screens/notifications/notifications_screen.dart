import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'type': 'course',
      'title': 'New Course Available',
      'message': 'Check out our new course on Flutter Development!',
      'time': DateTime.now().subtract(const Duration(minutes: 30)),
      'isRead': false,
      'action': 'View Course',
    },
    {
      'type': 'quiz',
      'title': 'Quiz Results',
      'message': 'You scored 85% in Flutter Basics Quiz',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': true,
      'action': 'View Results',
    },
    {
      'type': 'reminder',
      'title': 'Course Reminder',
      'message': 'Your next lesson starts in 1 hour',
      'time': DateTime.now().subtract(const Duration(hours: 4)),
      'isRead': false,
      'action': 'Join Now',
    },
    {
      'type': 'achievement',
      'title': 'Achievement Unlocked',
      'message': 'Completed 5 lessons in a row!',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': true,
      'action': 'View Achievements',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          actions: [
            IconButton(
              icon: const Icon(Icons.done_all),
              onPressed: () {
                _markAllAsRead();
              },
              tooltip: 'Mark all as read',
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Unread'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNotificationsList(_notifications),
            _buildNotificationsList(
              _notifications.where((n) => !n['isRead']).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsList(List<Map<String, dynamic>> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No notifications',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'You\'re all caught up!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final IconData icon;
    final Color color;

    switch (notification['type']) {
      case 'course':
        icon = Icons.school;
        color = Colors.blue;
        break;
      case 'quiz':
        icon = Icons.quiz;
        color = Colors.green;
        break;
      case 'reminder':
        icon = Icons.alarm;
        color = Colors.orange;
        break;
      case 'achievement':
        icon = Icons.emoji_events;
        color = Colors.purple;
        break;
      default:
        icon = Icons.notifications;
        color = Colors.grey;
    }

    return Dismissible(
      key: Key(notification['title']),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _deleteNotification(notification);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: InkWell(
          onTap: () {
            _handleNotificationTap(notification);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification['title'],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: notification['isRead']
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                  ),
                            ),
                          ),
                          Text(
                            _formatTime(notification['time']),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification['message'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              _handleActionTap(notification);
                            },
                            child: Text(notification['action']),
                          ),
                          if (!notification['isRead'])
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
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
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read')),
    );
  }

  void _deleteNotification(Map<String, dynamic> notification) {
    setState(() {
      _notifications.remove(notification);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _notifications.add(notification);
              _notifications.sort((a, b) =>
                  (b['time'] as DateTime).compareTo(a['time'] as DateTime));
            });
          },
        ),
      ),
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    if (!notification['isRead']) {
      setState(() {
        notification['isRead'] = true;
      });
    }
    // TODO: Navigate to notification content
  }

  void _handleActionTap(Map<String, dynamic> notification) {
    // TODO: Handle action based on notification type
    switch (notification['type']) {
      case 'course':
        // Navigate to course
        break;
      case 'quiz':
        // Show quiz results
        break;
      case 'reminder':
        // Join lesson
        break;
      case 'achievement':
        // Show achievements
        break;
    }
  }
}
