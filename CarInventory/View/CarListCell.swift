import Combine
import SwiftUI
import URLImage

struct CarListCell: View {
    private let viewModel: CarCellViewModel
    private let width: CGFloat
    
    /// This is a workaround for navigation in multiple-column list
    @State private var isNavigating: Bool = false
    
    init(viewModel: CarCellViewModel, width: CGFloat) {
        self.viewModel = viewModel
        self.width = width
    }
    
    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                NavigationLink(destination: CarDetailsView(viewModel: CarDetailsViewModel(carId: viewModel.id)), isActive: self.$isNavigating) {
                    carList
                    .onTapGesture {
                        self.isNavigating = true
                    }
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                carList
            }
        }
    }
    
    var carList: some View {
        VStack(spacing: 15) {
            if viewModel.mainPhotoUrl != nil {
                URLImage(viewModel.mainPhotoUrl!, placeholder: { _ in
                    // Placeholder image while loading from url
                    Image("CarPlaceholder")
                }) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
                .frame(width: width, height: width*2/3)
            } else {
                Image("CarPlaceholder")
            }
            HStack() {
                Text(viewModel.title)
                .bold()
                Spacer()
            }
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 0))
            HStack() {
                Text(viewModel.price)
                .font(.callout)
                Spacer()
            }
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 0))

            HStack {
                Spacer()
                Text(viewModel.location)
            }
            .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 15))
        }
    }
}
