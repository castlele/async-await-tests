import Cocoa

final class MainViewModel: ObservableObject {

    private let imageFetcher: ImageFetcher

    init(imageFetcher: ImageFetcher) {
        self.imageFetcher = imageFetcher
    }

    func fetchImage() async -> NSImage? {
        await imageFetcher.fetchImage()
    }
}
