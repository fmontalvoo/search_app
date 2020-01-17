import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final title;

  const Home({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchData([
                    'Quito',
                    'Guayaquil',
                    'Cuenca',
                    'Ambato',
                    'Santo Domingo',
                    'El Tambo'
                  ]));
            },
          )
        ],
      ),
      body: Center(),
      drawer: Drawer(),
    );
  }
}

class SearchData extends SearchDelegate {
  final ciudades;

  SearchData(this.ciudades);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = query.isEmpty
        ? ciudades
        : ciudades
            .where((q) => q.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.location_city),
        title: Text(suggestions[index]),
        onTap: () {
          showResults(context);
        },
      ),
      itemCount: suggestions.length,
    );
  }
}
