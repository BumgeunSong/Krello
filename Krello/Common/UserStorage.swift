import Foundation

struct UserStorage {
    private static let key = "userIdentifier"

    static func setUserIdentifier(uid: String) {
        UserDefaults.standard.set(uid, forKey: key)
    }

    static func getUserIdentifer() -> String? {
        return UserDefaults.standard.string(forKey: self.key) ?? nil
    }
}
