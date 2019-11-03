import SwiftUI

struct CarDetailsView: View {
    @ObservedObject var viewModel: CarDetailsViewModel
    
    init(viewModel: CarDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        LoadingView(isShowing: .constant(viewModel.loading)) {
            GeometryReader { geometry in
                VStack(spacing: 15) {
                    if self.viewModel.dataSource == nil {
                        self.emptySection
                    } else {
                        ImageSlider(imageUrls: self.viewModel.dataSource!.photoUrls)
                            .frame(width: geometry.size.width, height: geometry.size.width*2/3)
                        VStack(alignment: .leading, spacing: 15) {
                            Text(self.viewModel.dataSource!.location)
                            Text(self.viewModel.dataSource!.price)
                            Text(self.viewModel.dataSource!.saleStatus)
                            Text(self.viewModel.dataSource!.comments)
                                .font(.footnote)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
                    }
                    Spacer()
                }
            }
        }
        .onAppear(perform: viewModel.refresh)
    }
}

extension CarDetailsView {
    var emptySection: some View {
      Section {
        Text("No results")
            .font(.largeTitle)
            .foregroundColor(.gray)
      }
    }
}
