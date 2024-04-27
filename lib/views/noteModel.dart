class notemodel{
  var id;
  var title;
    var content;
    var folderId;
    
    notemodel({
      this.id, 
      this.title, 
      this.content, 
      this.folderId,     
     });

 notemodel.fromJson(Map<String , dynamic > json){
  id = json['id'];
  title = json['title'];
  content = json['content'];
  folderId = json['folderId'];
  
  
  

}
Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['folderId'] = folderId; 
    
    
    
    return data;
}

}