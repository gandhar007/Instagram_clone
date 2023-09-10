import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: const Icon(Icons.search),
        title: TextFormField(
          controller: searchController,
          onChanged: (String _) {setState(() {
            isShowUsers = true;
          });},
          decoration: const InputDecoration(
            hintText: 'Search for a user'
          ),
        ),
      ),
      body: isShowUsers ? FutureBuilder(
        future: FirebaseFirestore.instance.collection('users')
            .where('username', isGreaterThanOrEqualTo: searchController.text)
            .get(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(6),
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator
                    .of(context)
                    .push(
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                            uid: (snapshot.data! as dynamic).docs[index]['uid']
                        )
                    )
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage((snapshot.data! as dynamic).docs[index]['photoUrl']),
                  ),
                  title: Text((snapshot.data! as dynamic).docs[index]['username']),
                ),
              );
            },
          );
        },
      ) : FutureBuilder(
          future: FirebaseFirestore.instance.collection('posts').get(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(left: 0, right: 0, top: 6, bottom: 0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 1.5,
                  childAspectRatio: 1
              ),
                shrinkWrap: true,
                itemCount: (snapshot.data as dynamic).docs.length,
                itemBuilder: (context, index) => Image(
                  image: NetworkImage(
                      (snapshot.data as dynamic).docs[index]['postUrl']
                  ),
                ),
              ),
            );
          }
      )
    );
  }
}
