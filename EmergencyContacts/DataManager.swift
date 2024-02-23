import Foundation

class DataManager {
    var data: [DataItem.CategoryType: [DataItem]]?
    var errorMessage: String?
    
    func fetch(completion: @escaping (Result<[String: [DataItem]], Error>) -> Void) {
        guard let url = URL(string: "https://www.nouzovekontakty.cz/api/json") else {
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
                        self.data = Dictionary(grouping: jsonData, by: { $0.category })
                        completion(.success(self.data ?? [:]))
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
