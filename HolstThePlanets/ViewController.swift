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
    private var originalBackground: UIImage!
    private var filteredBackground: UIImage!
    
    @IBOutlet weak var btnMars: UIButton!
    @IBOutlet weak var btnVenus: UIButton!
    @IBOutlet weak var btnMercury: UIButton!
    @IBOutlet weak var btnJupiter: UIButton!
    @IBOutlet weak var btnUranus: UIButton!
    @IBOutlet weak var btnNeptune: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    
    @IBOutlet weak var lblMusicTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPlanetTitle: UILabel!
    @IBOutlet weak var lblPlanetSubtitle: UILabel!
    
    @IBOutlet weak var segCategory: UISegmentedControl!
    
    var iconButtons: [UIButton] {
        return [
            btnMars,
            btnVenus,
            btnMercury,
            btnJupiter,
            btnUranus,
            btnNeptune,
        ]
    }
    
    /// UIHosting 조정용
    var viewModel: CustomMusicSliderViewModel!
    
    var musicManager = MusicPlayManager(to: .Mars)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "astronomy")!)
        
        viewModel = CustomMusicSliderViewModel { [unowned self] value in
            if let player = musicManager.player, player.isPlaying {
                print(value)
                player.currentTime = value
            }
        }
        
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
        
        iconButtons.forEach { button in
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 1.0
            button.layer.shadowOffset = .zero
            button.layer.shadowRadius = 6
        }
        
        //
        // musicManager.player?.play()
        
        lblDescription.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        changePlanet(to: .Mars)
        originalBackground = imageViewBackground.image
        filteredBackground = originalBackground.maskWithColor(color: planetThemeColor(of: .Mars))
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [unowned self] timer in
            if let player = musicManager.player {
                // print(player.currentTime, player.duration)
                viewModel.inRange = 0 ... player.duration
                viewModel.value = player.currentTime
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func btnActSelectPlanet(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            changePlanet(to: .Mars)
        case 2:
            changePlanet(to: .Venus)
        case 3:
            changePlanet(to: .Mercury)
        case 4:
            changePlanet(to: .Jupiter)
        case 5:
            changePlanet(to: .Saturn)
        case 6:
            changePlanet(to: .Uranus)
        case 7:
            changePlanet(to: .Neptune)
        default:
            break
        }
    }
    
    @IBAction func btnActPlay(_ sender: UIButton) {
        togglePlayStatus()
    }
    
    @IBAction func segActCategoryChange(_ sender: UISegmentedControl) {
        updateDescription()
        filteredBackground = filteredBackground.filter(name: "CIColorInvert")
        // imageViewBackground.image = filteredBackground
    }
    
    
    // MARK: - IBAction Helper
    
    func changePlanet(to planet: PlanetName) {
        musicManager.change(to: planet)
        btnPlay.setImage(UIImage(systemName: musicManager.isPlaying ? "pause.fill" : "play.fill"), for: .normal)
        lblMusicTitle.text = musicManager.currentPlanet.playerTitle
        updateDescription()
        if let image = originalBackground {
            filteredBackground = image.maskWithColor(color: planetThemeColor(of: planet))
            // imageViewBackground.image = originalBackground
            UIView.transition(with: imageViewBackground, duration: 0.5, options: .transitionCrossDissolve) {
                self.imageViewBackground.image = self.originalBackground
            } completion: { _ in }
        }
    }

    func updateDescription() {
        // lblDescription.text = segCategory.selectedSegmentIndex == 0 ? musicManager.currentPlanet.astronomyDescription : musicManager.currentPlanet.astrologyDescription
        labelTransition(lblDescription, changeText: segCategory.selectedSegmentIndex == 0 ? musicManager.currentPlanet.astronomyDescription : musicManager.currentPlanet.astrologyDescription)
        // lblPlanetTitle.text = musicManager.currentPlanet.titleKorean
        labelTransition(lblPlanetTitle, changeText: musicManager.currentPlanet.titleKorean)
        // lblPlanetSubtitle.text = musicManager.currentPlanet.subtitleKorean
        labelTransition(lblPlanetSubtitle, changeText: musicManager.currentPlanet.subtitleKorean)
    }
    
    func togglePlayStatus() {
        guard let player = musicManager.player else {
            return
        }
        
        if player.isPlaying {
            player.stop()
            // imageViewBackground.image = originalBackground
            UIView.transition(with: imageViewBackground, duration: 0.5, options: .transitionCrossDissolve) {
                self.imageViewBackground.image = self.originalBackground
            } completion: { _ in }
        } else {
            player.play()
            // imageViewBackground.image = filteredBackground
            UIView.transition(with: imageViewBackground, duration: 1, options: .transitionCrossDissolve) {
                self.imageViewBackground.image = self.filteredBackground
            } completion: { _ in }
        }
        
        btnPlay.setImage(UIImage(systemName: player.isPlaying ? "pause.fill" : "play.fill"), for: .normal)
    }
    
    func planetThemeColor(of planet: PlanetName) -> UIColor {
        switch planet {
        case .Mars:
            return .red
        case .Venus:
            return .orange
        case .Mercury:
            return .lightGray
        case .Jupiter:
            return .yellow
        case .Saturn:
            return .brown
        case .Uranus:
            return UIColor(red: 7/255, green: 145/255, blue: 250/255, alpha: 1)
        case .Neptune:
            return UIColor(red: 76/255, green: 205/255, blue: 245/255, alpha: 1)
        }
    }
    
    func labelTransition(_ label: UILabel, changeText: String, duration: TimeInterval = 0.2) {
        UIView.transition(with: label, duration: duration, options: .transitionCrossDissolve) {
            label.text = changeText
        } completion: { _ in }
    }
}

