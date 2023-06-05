import SwiftUI

@MainActor
struct MainView: View {

    @EnvironmentObject var mainViewModel: MainViewModel
    @State private var image: NSImage?

    var body: some View {
        ZStack {
            if let image = image {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("No image here")
            }

        }
        .frame(width: 1024, height: 768)
        .task {
            image = await mainViewModel.fetchImage()
        }
        .overlay(alignment: .bottom) {
            Button("Regenerate image") {
                Task {
                    image = await mainViewModel.fetchImage()
                }
            }
        }
    }
}
