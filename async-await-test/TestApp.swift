import SwiftUI

@main
struct TestApp: App {

    @ObservedObject var mainViewModel: MainViewModel

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(mainViewModel)
        }
    }

    init() {
        guard let key = ProcessInfo.processInfo.environment["CAT_API_KEY"] else {
            fatalError("Add api key to environment")
        }

        let configurator = RequestConfigurator("https://api.thecatapi.com/v1/images/MTk3Mjk5MA",
                                               query: [URLQueryItem(name: "api_key", value: key)])
        let imageFetcher = NetworkImageFetcher(requestConfigurator: configurator)

        mainViewModel = MainViewModel(imageFetcher: imageFetcher)
    }
}
