import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> _chats = [
    {
      'id': '1',
      'name': 'John Doe',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'lastMessage':
          'Could you explain the difference between StatelessWidget and StatefulWidget?',
      'time': DateTime.now().subtract(const Duration(minutes: 30)),
      'unreadCount': 0,
      'isOnline': true,
      'typing': false,
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'avatar': 'https://i.pravatar.cc/150?img=2',
      'lastMessage': 'Great! I\'ll check it out.',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'unreadCount': 3,
      'isOnline': false,
      'typing': false,
    },
    {
      'id': '3',
      'name': 'Flutter Course Support',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'lastMessage': 'How can I help you with the course?',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'unreadCount': 0,
      'isOnline': true,
      'typing': true,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : const Text('Messages'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
      ),
      body: _chats.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return _buildChatTile(chat);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Start new chat
        },
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search conversations...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onChanged: (value) {
        // TODO: Implement search
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No conversations yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Start chatting with your instructors\nand fellow students',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              // TODO: Start new chat
            },
            icon: const Icon(Icons.add),
            label: const Text('Start a conversation'),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(Map<String, dynamic> chat) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/chat',
          arguments: {
            'chatId': chat['id'],
            'recipientName': chat['name'],
          },
        );
      },
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(chat['avatar'] as String),
          ),
          if (chat['isOnline'] as bool)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              chat['name'] as String,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: (chat['unreadCount'] as int) > 0
                        ? FontWeight.bold
                        : null,
                  ),
            ),
          ),
          Text(
            _formatTime(chat['time'] as DateTime),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: (chat['unreadCount'] as int) > 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          if (chat['typing'] as bool)
            Text(
              'typing...',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Expanded(
              child: Text(
                chat['lastMessage'] as String,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: (chat['unreadCount'] as int) > 0
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          if ((chat['unreadCount'] as int) > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                chat['unreadCount'].toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ],
        ],
      ),
      onLongPress: () {
        _showChatOptions(chat);
      },
    );
  }

  void _showChatOptions(Map<String, dynamic> chat) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.mark_chat_read),
              title: const Text('Mark as read'),
              enabled: (chat['unreadCount'] as int) > 0,
              onTap: () {
                setState(() {
                  chat['unreadCount'] = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_off),
              title: const Text('Mute conversation'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement mute
              },
            ),
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text('Archive conversation'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement archive
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                'Delete conversation',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(chat);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> chat) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Conversation'),
          content: Text(
            'Are you sure you want to delete your conversation with ${chat['name']}? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  _chats.remove(chat);
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (time.year == now.year &&
        time.month == now.month &&
        time.day == now.day) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (time.year == now.year &&
        time.month == now.month &&
        time.day == now.day - 1) {
      return 'Yesterday';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}
