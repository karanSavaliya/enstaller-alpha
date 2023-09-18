// @dart=2.9
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  List<Map<String, dynamic>> listSearch;

  SearchPage(this.listSearch);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> _allUsers;

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  initState() {
    setState(() {
      _allUsers = widget.listSearch;
      _foundUsers = widget.listSearch;
    });
    print("------" + _allUsers.toString());
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];

    if (enteredKeyword.trim().isEmpty) {
      results = _allUsers;
    } else {
      String lowercaseKeyword = enteredKeyword.trimLeft().toLowerCase();
      results = _allUsers
          .where(
              (user) => user["label"].toLowerCase().contains(lowercaseKeyword))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) {
                        return Container(
                          key: ValueKey(_foundUsers[index]["id"]),
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          child: ListTile(
                            title: Text(
                              _foundUsers[index]['label'],
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            onTap: () {
                              print("testtttttttttttt");
                              print(_foundUsers[index].toString() +
                                  "))))))))))))");
                              if (_foundUsers.length > 0) {
                                Navigator.pop(
                                    context,
                                    _foundUsers[index]["label"] +
                                        "**" +
                                        _foundUsers[index]["value"] +
                                        "**" +
                                        _foundUsers[index]["intContractId"]);
                              }
                            },
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                      'No items found',
                      style: TextStyle(fontSize: 24),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
