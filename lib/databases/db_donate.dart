//import 'package:sqflite/sqflite.dart';
//import '../databases/db_helper.dart';
import '../databases/db_base.dart';

class DBDonateTable extends DBBaseTable {
  @override
  var db_table = 'Donate';
  
  static String sql_code = '''
   
 

    

    CREATE TABLE User_Donation (
        user_donation_id INTEGER PRIMARY KEY,
        contact TEXT,
        color TEXT,
        condition TEXT CHECK(condition IN ('new', 'used', 'good', 'bad'))
    );

    CREATE TABLE Campaign (
        campaign_id INTEGER PRIMARY KEY,
        type TEXT CHECK(type IN ('event', 'donation')),
        resource INTEGER,
        description TEXT
    );

    CREATE TABLE Contact (
        contact_id INTEGER PRIMARY KEY,
        organization_id INTEGER,
        participant_id INTEGER,
        content TEXT,
        FOREIGN KEY (organization_id) REFERENCES Organization(organization_id),
        FOREIGN KEY (participant_id) REFERENCES Participant(participant_id),
        CHECK (organization_id IS NULL OR participant_id IS NULL)  
    );


    CREATE TABLE Card (
        card_id INTEGER PRIMARY KEY,
        image BLOB,
        location TEXT,
        title TEXT
    );

    CREATE TABLE Social_Media (
        social_media_id INTEGER PRIMARY KEY,
        platform TEXT,
        url_path TEXT
    );

    CREATE TABLE Notification (
        notif_id INTEGER PRIMARY KEY,
        sender_id INTEGER,
        receiver_id INTEGER,
        message TEXT,
        status TEXT CHECK(status IN ('read', 'unread')),
        action TEXT CHECK(action IN ('accept', 'decline', 'null')),
        date_sent DATE
    );

    CREATE TABLE Organization_Apply (
        organization_apply_id INTEGER PRIMARY KEY,
        organization_id INTEGER,
        FOREIGN KEY (organization_id) REFERENCES Organization(organization_id)
    );

    CREATE TABLE User (
        email TEXT PRIMARY KEY,
        password TEXT,
        contact_id INTEGER,
        FOREIGN KEY (contact_id) REFERENCES Contact(contact_id)
    );
  ''';
}
