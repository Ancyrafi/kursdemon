part of 'blog_cubit.dart';

class BlogState {
  BlogState({required this.load, required this.blog});
  bool load;
  final List<Blog> blog;
}
