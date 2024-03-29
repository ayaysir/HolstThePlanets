//
//  CustomMusicSliderView.swift
//  HolstThePlanets
//
//  Created by 윤범태 on 2023/06/08.
//

import UIKit
import SwiftUI

class CustomMusicSliderViewModel: ObservableObject {
    typealias DragHandler = ((Double) -> Void)
    
    @Published var value: Double = 20.0
    @Published var inRange: ClosedRange<Double> = 0.0 ... 60.0
    
    @Published var dragHandler: DragHandler? = { _ in }
    
    init(dragHandler: DragHandler? = nil) {
        self.dragHandler = dragHandler
    }
}

struct CustomMusicSliderView: View {
    @StateObject var viewModel: CustomMusicSliderViewModel
    
    var body: some View {
        ZStack {
            // Color.black.ignoresSafeArea()
            VStack {
                MusicProgressSlider(value: $viewModel.value, inRange: viewModel.inRange, activeFillColor: .white, fillColor: .white.opacity(0.5), emptyColor: .white.opacity(0.3), height: 32) { isDragStarted, value in
                    if !isDragStarted {
                        print("drag stopped", value)
                        viewModel.dragHandler?(value)
                    }
                }
                .frame(height: 40)
            }
            // .padding()
        }
    }
}

struct CustomMusicSliderView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = CustomMusicSliderViewModel()
        CustomMusicSliderView(viewModel: vm)
    }
}
