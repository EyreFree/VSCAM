
import Foundation

class NetworkError {

    var description: String!
    var error: String!

    init?(dict: NSDictionary) {
        if let tryError = dict["error"] as? String {
            self.error = tryError
            self.description = NetworkError.getContent(tryError)
        } else {
            return nil
        }
    }

    static func getContent(_ error: String) -> String {
        switch error {
        default:
            return error
        }
    }
}
