import Cocoa

protocol ImageFetcher {
    func fetchImage() async -> NSImage?
}
