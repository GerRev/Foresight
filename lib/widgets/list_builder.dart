import 'package:flutter/material.dart';
import 'package:foresight_mobile/widgets/no_content.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item);


//Custom builder to simplify UI code. Handles 4 different states: Loading, Empty, Error and Data from a snapshot.

class ListsBuilder<T> extends StatelessWidget {
  const ListsBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
    this.content,

  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemBuilder<T> itemBuilder;
  final String content;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return NoContent(
          message: content,
        );
      }
    } else if (snapshot.hasError) {
      return NoContent(
        title: 'Something went wrong',
        message: 'Unable to laod data',
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      itemCount: items.length + 2,
      separatorBuilder: (context, index) => Divider(height: 0.5),
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container();
        }
        return itemBuilder(context, items[index - 1]);
      },
    );
  }
}
