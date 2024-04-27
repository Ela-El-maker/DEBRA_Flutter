class foldermodel{
  var folderId;
  var folderName;
    var username;
    
    foldermodel({
      this.folderId, 
     this.folderName, 
     this.username,
     });

 foldermodel.fromJson(Map<String , dynamic > json){
  folderId = json['folderId'];
  folderName = json['folderName'];
  username =json['username'];
  

}
Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['folderId'] = folderId; // Serialize the 'id' field
    data['folderName'] = folderName;
    data['username'] = username;
    
    return data;
}

}