class Category {
   int? id  ;
   String name;
   String description;

    Category({required this.name, required this.description,  this.id});

    categoryMap(){
      var mapping = <String, dynamic>{};
      if (id != null) mapping['id'] = id;
      mapping['name'] = name;
      mapping['description'] = description;
      return mapping;
    }

}