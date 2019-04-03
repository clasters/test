import Alamofire

class NetworkManager: NSObject {
    enum Result<T, U: Error> {
        case success(payload: T)
        case failure(U?)
    }
    
    enum GetProfilesFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias GetProfilesResult = Result<Root, GetProfilesFailureReason>
    typealias GetProfilesCompletion = (_ result: GetProfilesResult) -> Void
    
    func fetchProfile(completion: @escaping (Root) -> ()) {
        
        AF.request("https://pastebin.com/raw/P4QUHz2y")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {  return }
                        
                        let profiles = try JSONDecoder().decode(Root.self, from: data)
                        completion(profiles)
                    } catch {
                        print("error")
                    }
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = GetProfilesFailureReason(rawValue: statusCode) {
                        print(reason)
                    }
                }
        }
        
    }
}
