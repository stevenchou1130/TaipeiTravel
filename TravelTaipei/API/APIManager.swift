//
//  APIManager.swift
//  TravelTaipei
//
//  Created by Steven on 2025/2/5.
//

import Foundation

// MARK: - APIError
enum APIError: Error {
    case apiError(Error)
    case clientError
    case serverError
    case decodingError(Error)
    case unknownError
}

// MARK: - APIContent
enum APIContent {
    case attractionsAll(page: String)
    case eventsNews(page: String)

    var baseURL: String {
        return "https://www.travel.taipei/open-api/"
    }

    var path: String {
        switch self {
        case .attractionsAll:
            return "/Attractions/All"
        case .eventsNews:
            return "/Events/News"
        }
    }

    // TODO: 多國語系
    var lang: String {
        return "zh-tw"
    }

    var method: String {
        switch self {
        case .attractionsAll:
            return "GET"
        case .eventsNews:
            return "GET"
        }
    }

    var headers: [String: String] {
        return [
            "accept": "application/json"
        ]
    }

    var parameters: [String: String] {
        switch self {
        case .attractionsAll(page: let page):
            return ["page": page]
        case .eventsNews(page: let page):
            return ["page": page]
        }
    }

    var urlRequest: URLRequest {
        var components = URLComponents(string: baseURL + lang + path)!
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers

        return request
    }
}

// MARK: - APIManager
class APIManager {

    static let shared = APIManager()

    func request<T: Codable>(apiContent: APIContent,
                             model: T.Type,
                             completion: @escaping (Result<T, APIError>) -> Void) {

        let session = URLSession.shared

        let task = session.dataTask(with: apiContent.urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.apiError(error)))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if (400...499).contains(httpResponse.statusCode) {
                    completion(.failure(.clientError))
                    return
                } else if (500...599).contains(httpResponse.statusCode) {
                    completion(.failure(.serverError))
                    return
                }
            }

            guard let data = data else {
                completion(.failure(.unknownError))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model = try decoder.decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }

        task.resume()
    }
}
