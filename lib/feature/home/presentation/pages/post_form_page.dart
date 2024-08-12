import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/feature/home/presentation/manager/post_provider.dart';

import '../../domain/entities/post.dart';

class PostFormPage extends StatefulWidget {
  final Post? post;

  const PostFormPage({super.key, this.post});

  @override
  _PostFormPageState createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _body;

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _title = widget.post!.title;
      _body = widget.post!.body;
    } else {
      _title = '';
      _body = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? 'Create Post' : 'Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  _title = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _body,
                decoration: InputDecoration(labelText: 'Body'),
                onSaved: (value) {
                  _body = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final post = Post(
                      id: widget.post?.id ?? 0,
                      title: _title,
                      body: _body,
                    );

                    if (widget.post == null) {
                      postProvider.addPost(post);
                    } else {
                      postProvider.modifyPost(post);
                    }

                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.post == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
