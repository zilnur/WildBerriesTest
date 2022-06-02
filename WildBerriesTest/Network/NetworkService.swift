import Foundation

struct Ticket: Decodable {
    let startCity: String
    let endCity: String
    let startDate: String
    let endDate: String
    let price: Int
    let searchToken: String
}

class MainRequest: Decodable {
    let data: [Ticket]
}

class NetworkService {
    
    static let shared = NetworkService()
    
    func getTickets(_ completion: @escaping (MainRequest) -> Void) {
        guard let url = URL(string:  "https://travel.wildberries.ru/statistics/v1/cheap") else { return }
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let fromData = data else { return }
            do {
                let request = try JSONDecoder().decode(MainRequest.self, from: fromData)
                completion(request)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        session.resume()
    }
}
