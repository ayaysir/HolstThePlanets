//
//  ViewController.swift
//  HolstThePlanets
//
//  Created by 윤범태 on 2023/06/08.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var viewCustomSlider: UIView!
    @IBOutlet weak var viewIconList: UIView!
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    var viewModel = CustomMusicSliderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "astronomy")!)
        
        let sliderVC = UIHostingController(rootView: CustomMusicSliderView(viewModel: self.viewModel))
        let embedSliderView = sliderVC.view!
        embedSliderView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChild(sliderVC)
        viewCustomSlider.addSubview(embedSliderView)
        
        viewCustomSlider.backgroundColor = .clear
        embedSliderView.backgroundColor = .clear
        viewIconList.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            // embedSliderView.centerXAnchor.constraint(equalTo: viewCustomSlider.centerXAnchor),
            // embedSliderView.centerYAnchor.constraint(equalTo: viewCustomSlider.centerYAnchor),
            embedSliderView.topAnchor.constraint(equalTo: viewCustomSlider.topAnchor),
            embedSliderView.bottomAnchor.constraint(equalTo: viewCustomSlider.bottomAnchor),
            embedSliderView.leadingAnchor.constraint(equalTo: viewCustomSlider.leadingAnchor),
            embedSliderView.trailingAnchor.constraint(equalTo: viewCustomSlider.trailingAnchor),
        ])
        
        sliderVC.didMove(toParent: self)
        
        imageViewBackground.rotate(duration: 60)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.viewModel.value += 0.1
        }
    }
}

