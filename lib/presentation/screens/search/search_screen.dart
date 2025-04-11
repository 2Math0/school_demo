import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/course/course_cubit.dart';
import '../../widgets/course_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1200;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search courses...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<CourseCubit>().loadCourses(searchQuery: '');
              },
            ),
          ),
          onChanged: (query) {
            context.read<CourseCubit>().loadCourses(searchQuery: query);
          },
        ),
      ),
      body: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CourseError) {
            return Center(child: Text(state.message));
          }

          if (state is CourseLoaded) {
            final courses = state.courses;
            if (courses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No courses found',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try different keywords',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop
                    ? 32
                    : isTablet
                        ? 24
                        : 16,
                vertical: 16,
              ),
              child: CourseList(courses: courses),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
