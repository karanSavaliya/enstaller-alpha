// @dart=2.9


import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {


  List<Map<String ,dynamic>> listSearch;
  SearchPage(this.listSearch);

  @override
  State<SearchPage> createState() => _SearchPageState();

}


class _SearchPageState extends State<SearchPage> {

  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well

  List<Map<String, dynamic>> _allUsers ;
  List<Map<String, dynamic>> _foundUsers = [];

  @override
  initState() {
    // at the beginning, all users are shown


    setState(() {
      _allUsers = widget.listSearch;
      _foundUsers = widget.listSearch;
    });

    print("------"+_allUsers.toString());

    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers.where((user) => user["label"].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      results = _allUsers.where((user) => user["label"].contains(enteredKeyword)).toList();

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
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
                  labelText: 'Search' , suffixIcon: Icon(Icons.search)),
            ),

            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) {  return /*GestureDetector(onTap: (){


                  print("tttttttttttt");

                  print(_foundUsers[index].toString()+"))))))))))))");

                  if(_foundUsers.length > 0) {
                    Navigator.of(context).pop(_foundUsers[index]);
                  }

                }   ,child:*/Container(
                  key: ValueKey(_foundUsers[index]["id"]),
                  margin: const EdgeInsets.symmetric(vertical: 0),
                  child:ListTile(
                    title: Text(_foundUsers[index]['label'] , style: TextStyle(fontSize:14 , fontWeight: FontWeight.w500),),
                    onTap: (){

                      
                      print("testtttttttttttt");
                      print(_foundUsers[index].toString()+"))))))))))))");

                      if(_foundUsers.length > 0) {
                       // Navigator.of(context).pop(_foundUsers[index]);

                        Navigator.pop(context, _foundUsers[index]["label"]+"**"+_foundUsers[index]["value"]+"**"+_foundUsers[index]["intContractId"]);

                      }

                    },
                  ),
                );
                                              } )
                  :  Center(child:Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              )),
            ),
          ],
        ),
      ),
    );
  }
}