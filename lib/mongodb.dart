import 'dart:developer';

import 'package:login_signup/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase{
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    var collection = db.collection(COLLECTION_NAME);

    /*await collection.insertOne({
      "name": "user1",
      "type": "admin",
      "column": {
      }
    });*/
    //print(await collection.find().toList());

    //await collection.update(where.eq("name", "user1"), modify.set("name", "user2"));
    await collection.deleteOne({"name": "user2"});
  }
}