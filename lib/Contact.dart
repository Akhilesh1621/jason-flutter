class Contact {
  String _name,_email;
  int _age;

  Contact(this._name,this._email,this._age);

  factory Contact.fromJSON(Map<String,dynamic> json){
    if(json == null){
      return null;
    }else {
      return Contact(json["name"],json["email"],json["age"]);
    }
  }

  get name => this._name;
  get email => this._email;
  get age => this._age;

}