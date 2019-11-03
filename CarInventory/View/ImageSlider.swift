import SwiftUI
import URLImage

struct ImageSlider: View {
    private var imageUrls: [URL?]
    
    init(imageUrls: [URL?]) {
        self.imageUrls = imageUrls
    }
    
    var body: some View {
        GeometryReader { proxy in
            // TODO: SwiftUI ScrollView currently doesn't support pagination, should either wait for Apple to update or make our own SwiftUI ImageSlider by UIViewRepresentable (integrating with UIKit)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(self.imageUrls, id: \.self) { url in
                        Group {
                            if url != nil {
                                URLImage(url!, placeholder: { _ in
                                    // Placeholder image while loading from url
                                    Image("CarPlaceholder")
                                }) { proxy in
                                    proxy.image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                }
                                .frame(width: proxy.size.width, height: proxy.size.height)
                            } else {
                                Image("CarPlaceholder")
                                    .frame(width: proxy.size.width, height: proxy.size.height)
                            }
                        }
                    }
                }
            }
        }
    }
}
