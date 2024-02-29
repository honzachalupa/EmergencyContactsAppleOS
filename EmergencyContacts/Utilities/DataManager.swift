import Foundation
import SwiftData

class DataStore: ObservableObject {
    @Published var data: [DataItem]!
    @Published var dataGrouped: [DataItem.CategoryType: [DataItem]];
    @Published var errorMessage: String!
    
    init() {
        self.data = []
        self.dataGrouped = [:];
        self.errorMessage = nil
        
        DataManager().fetch() { result in
            switch result {
                case .success(let fetchedData):
                    self.data = fetchedData
                    self.dataGrouped = groupByCategory(fetchedData)
                case .failure(let error):
                    self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
            }
        }
    }
}


class DataManager {
    var data: [DataItem]?
    var errorMessage: String?
    
    // @Environment(\.modelContext) var context
    
    /* init(data: [DataItem]? = nil, errorMessage: String? = nil) {
        self.data = data
        self.errorMessage = errorMessage
    } */
    
    func fetch(completion: @escaping (Result<[DataItem], Error>) -> Void) {
        /* guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            print("Error: API_KEY not found")
            return
        } */
        
        guard let url = URL(string: "https://www.nouzovekontakty.cz/api/json?apiKey=\(apiKey)") else {
            self.errorMessage = "Invalid URL"
            completion(.failure(NSError(domain: "DataManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error fetching data: \(error)"
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    if let httpResponse = response as? HTTPURLResponse {
                        self.errorMessage = "Error with the response, unexpected status code: \(httpResponse.statusCode)"
                        let error = NSError(domain: "DataManager", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Error with the response, unexpected status code: \(httpResponse.statusCode)"])
                        completion(.failure(error))
                    } else {
                        self.errorMessage = "Error with the response, unexpected status code"
                        completion(.failure(NSError(domain: "DataManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error with the response, unexpected status code"])))
                    }
                }
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([DataItem].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.data = jsonData
                        
                        /* jsonData.forEach { item in
                            context.insert(item)
                        } */
                        
                        completion(.success(jsonData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Error parsing JSON data: \(error)"
                        
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
