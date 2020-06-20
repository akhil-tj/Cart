import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expansion(),
    );
  }
}

class Expansion extends StatefulWidget {
  @override
  _ExpansionState createState() => _ExpansionState();
}

class _ExpansionState extends State<Expansion> {
  // Same here
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => EntryItem(data[index]),
      itemCount: data.length,
      shrinkWrap: true,
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, this.avatar, this.count);

  final String title;
  final String avatar;
  int count;

  void incrementCount() {
    count++;
  }

  void decrementCount() {
    if(count>0) {
      count--;
    }
  }
}

// The entire multilevel list displayed by this app.
final List data = [
  Entry('Chapter A', 'A', 0),
  Entry('Chapter B', 'B', 0),
  Entry('Chapter C', 'C', 0),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.

class EntryItem extends StatefulWidget {
  final Entry entry;
  EntryItem(this.entry); // Code goes here
  @override
  _EntryItemState createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {
  // State<EntryItem> remember to give type for state class
  Entry entry;

  @override
  initState() {
    entry = widget.entry; // Getting value
    super.initState();
  }

  Widget _buildTiles(Entry root) {
    return ListTile(
      leading: ExcludeSemantics(
        child: CircleAvatar(
          child: Text(
            root.avatar,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      key: PageStorageKey(root),
      title: Text(root.title),
      trailing: Container(
        child: Row(
          mainAxisSize: MainAxisSize
              .min, // Use minimum main axis size and remove expanded
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    entry.decrementCount();
                  });
                },
                child: Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Icon(Icons.minimize))),
            Text(entry.count.toString()),
            GestureDetector(
                onTap: () {
                  setState(() {
                    entry.incrementCount();
                  });
                },
                child: Icon(Icons.add))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
