import SwiftUI

struct CarListView: View {
    @ObservedObject var viewModel: CarListViewModel
    
    init(viewModel: CarListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        LoadingView(isShowing: .constant(viewModel.loading)) {
            NavigationView {
                GeometryReader { geometry in
                    if self.viewModel.dataSource.isEmpty {
                        self.emptySection
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    } else {
                        ScrollView {
                            VStack {
                                if UIDevice.current.userInterfaceIdiom == .pad {
                                    // ipad
                                    if geometry.size.width < geometry.size.height {
                                        // show 2 columns if portrait
                                        ForEach(self.viewModel.dataSource.chunks(chunkSize: 2), id: \.self) { rows in
                                            CarListRow(columns: 2, dataSource: rows, width: geometry.size.width)
                                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                            .navigationViewStyle(StackNavigationViewStyle())
                                        }
                                    } else {
                                        // show 3 columns if landscape
                                        ForEach(self.viewModel.dataSource.chunks(chunkSize: 3), id: \.self) { rows in
                                            CarListRow(columns: 3, dataSource: rows, width: geometry.size.width)
                                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                        }
                                    }
                                } else {
                                    // iphone
                                    ForEach(self.viewModel.dataSource, id: \.self) { vm in
                                        NavigationLink(destination: CarDetailsView(viewModel: CarDetailsViewModel(carId: vm.id))) {
                                            CarListCell(viewModel: vm, width: geometry.size.width)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Stocks"))
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .alert(isPresented: .constant(self.viewModel.error != nil)) {
                Alert(title: Text("Error"), message: Text(self.viewModel.error!.localizedDescription), dismissButton: .default(Text("OK")))
            }
        }
    }
}

private extension CarListView {
    
    var emptySection: some View {
      Section {
        Text("No results")
            .font(.largeTitle)
            .foregroundColor(.gray)
      }
    }
    
    /// This list row is designed to fill up the space in multiple-column row
    struct CarListRow: View {
        let columns: Int
        let dataSource: [CarCellViewModel]
        let width: CGFloat
        
        var body: some View {
            HStack {
                ForEach(self.dataSource, id: \.self) { vm in
                    VStack {
                        HStack {
                            Spacer()
                            CarListCell(viewModel: vm, width: self.width/CGFloat(self.columns) - 10)
                            Spacer()
                            Divider()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
                ForEach(0..<self.columns-self.dataSource.count, id: \.self) { _ in
                    Spacer()
                }
            }
        }
    }
}
