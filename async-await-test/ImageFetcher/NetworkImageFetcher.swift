import Cocoa

struct NetworkImageFetcher: ImageFetcher {

    private let requestConfigurator: RequestConfigurator

    init(requestConfigurator: RequestConfigurator) {
        self.requestConfigurator = requestConfigurator
    }

    func fetchImage() async -> NSImage? {
        let request = requestConfigurator.createRequest()

        let result = try? await URLSession.shared.data(for: request)

        guard let catModel: CatImageModel = decode(result?.0) else {
            return nil
        }

        return await requestImage(catModel.url)
    }

    private func requestImage(_ url: String) async -> NSImage? {
        guard let url = URL(string: url) else {
            return nil
        }

        let result = try? await URLSession.shared.data(from: url)

        guard let result else {
            return nil
        }

        return NSImage(data: result.0)
    }

    private func decode<T: Decodable>(_ data: Data?) -> T? {
        guard let data else {
            return nil
        }

        return try? JSONDecoder().decode(T.self, from: data)
    }
}
