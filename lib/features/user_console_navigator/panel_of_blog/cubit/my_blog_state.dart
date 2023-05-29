part of 'my_blog_cubit.dart';

class MyBlogState {
  MyBlogState(
      {required this.addBlog, required this.editBlog, required this.blogText});
  bool addBlog;
  bool editBlog;
  final List<Blog> blogText;

  MyBlogState copyWith({bool? addBlog, bool? editBlog, List<Blog>? blogText}) {
    return MyBlogState(
        addBlog: addBlog ?? this.addBlog,
        editBlog: editBlog ?? this.editBlog,
        blogText: blogText ?? this.blogText);
  }
}
