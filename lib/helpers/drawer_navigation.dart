import 'package:flutter/material.dart';
import 'package:flutter_todolist_sqflite_app/screens/home_screen.dart';
import 'package:flutter_todolist_sqflite_app/service/category_service.dart';

import '../screens/categories_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = <Widget>[];
  CategoryService _categoryService = CategoryService();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }
  getAllCategories() async {
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categoryList.add(ListTile(
          title: Text(category['name']),
          onTap: () {

          },
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Abu Sayem"),
              accountEmail: Text("abusayem@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://picsum.photos/200/300"),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const HomeScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.view_list),
              title: const Text("Categories"),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const CategoriesScreen())),

            ),
            const Divider(),
            Column(
              children: _categoryList,
            )
          ],
        ),
      ),
    );
  }
}
