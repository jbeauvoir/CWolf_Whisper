
import Foundation
import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
        static let databaseForums = databaseRoot.child("Forums")
        static let databaseUsers = databaseRoot.child("Users")
        static let databasUsername = databaseUsers.child("username")
    }
}
