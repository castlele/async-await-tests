import Foundation

struct RequestConfigurator {

    private let url: URL
    private let query: [URLQueryItem]
    private let headers: [String: String]

    init(_ url: String, query: [URLQueryItem] = [], headers: [String: String] = [:]) {
        guard let url = URL(string: url) else {
            fatalError("Invalid url passed: {\(url)}")
        }

        self.url = url
        self.query = query
        self.headers = headers
    }

    func createRequest() -> URLRequest {
        var request = URLRequest(url: url.appending(queryItems: query))

        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        return request
    }
}
