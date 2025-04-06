import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String quizId;
  final String quizTitle;

  const QuizScreen({
    super.key,
    required this.quizId,
    required this.quizTitle,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final List<int?> _selectedAnswers = List.filled(5, null);
  bool _isSubmitted = false;

  // Sample questions - Replace with actual data from backend
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the main purpose of Flutter\'s widget tree?',
      'options': [
        'To organize the code structure',
        'To define the user interface hierarchy',
        'To manage state',
        'To handle user input',
      ],
      'correctAnswer': 1,
    },
    {
      'question': 'Which widget is used for scrollable content in Flutter?',
      'options': [
        'Container',
        'Column',
        'ListView',
        'Stack',
      ],
      'correctAnswer': 2,
    },
    // Add more questions here
  ];

  void _selectAnswer(int answerIndex) {
    if (!_isSubmitted) {
      setState(() {
        _selectedAnswers[_currentQuestionIndex] = answerIndex;
      });
    }
  }

  void _submitQuiz() {
    setState(() {
      _isSubmitted = true;
    });
    // TODO: Save quiz results
  }

  int _calculateScore() {
    int correctAnswers = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i]['correctAnswer']) {
        correctAnswers++;
      }
    }
    return correctAnswers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quizTitle),
        actions: [
          TextButton.icon(
            onPressed: _isSubmitted ? null : _submitQuiz,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Submit'),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          Expanded(
            child: PageView.builder(
              physics: _isSubmitted
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              itemCount: _questions.length,
              onPageChanged: (index) {
                setState(() {
                  _currentQuestionIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildQuestionCard(index);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          _isSubmitted ? _buildResultsBar() : _buildNavigationBar(),
    );
  }

  Widget _buildQuestionCard(int index) {
    final question = _questions[index];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${index + 1} of ${_questions.length}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            question['question'],
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          ...List.generate(
            question['options'].length,
            (optionIndex) => _buildOptionCard(
              option: question['options'][optionIndex],
              isSelected: _selectedAnswers[index] == optionIndex,
              isCorrect:
                  _isSubmitted && question['correctAnswer'] == optionIndex,
              isWrong: _isSubmitted &&
                  _selectedAnswers[index] == optionIndex &&
                  question['correctAnswer'] != optionIndex,
              onTap: () => _selectAnswer(optionIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required String option,
    required bool isSelected,
    required bool isCorrect,
    required bool isWrong,
    required VoidCallback onTap,
  }) {
    Color? backgroundColor;
    Color? borderColor;

    if (_isSubmitted) {
      if (isCorrect) {
        backgroundColor = Colors.green.withOpacity(0.1);
        borderColor = Colors.green;
      } else if (isWrong) {
        backgroundColor = Colors.red.withOpacity(0.1);
        borderColor = Colors.red;
      }
    } else if (isSelected) {
      backgroundColor = Theme.of(context).colorScheme.primaryContainer;
      borderColor = Theme.of(context).colorScheme.primary;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor ?? Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              if (_isSubmitted && isCorrect)
                const Icon(Icons.check_circle, color: Colors.green)
              else if (_isSubmitted && isWrong)
                const Icon(Icons.cancel, color: Colors.red)
              else if (isSelected)
                Icon(Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            TextButton.icon(
              onPressed: _currentQuestionIndex > 0
                  ? () {
                      setState(() {
                        _currentQuestionIndex--;
                      });
                    }
                  : null,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Previous'),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: _currentQuestionIndex < _questions.length - 1
                  ? () {
                      setState(() {
                        _currentQuestionIndex++;
                      });
                    }
                  : null,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsBar() {
    final score = _calculateScore();
    final percentage = (score / _questions.length * 100).round();

    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quiz Complete!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'You scored $score out of ${_questions.length} ($percentage%)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Review answers
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Review Answers'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
