//
//  MusicPlayManager.swift
//  HolstThePlanets
//
//  Created by 윤범태 on 2023/06/08.
//

import AVFoundation

fileprivate let fileExtension = "mp3"

enum PlanetName: String {
    
    case Mars
    case Venus
    case Mercury
    case Jupiter
    case Saturn
    case Uranus
    case Neptune
    
    var url: URL! {
        Bundle.main.url(forResource: self.rawValue, withExtension: fileExtension)
    }
}

class MusicPlayManager {
    private(set) var player: AVAudioPlayer?
    
    init(to planet: PlanetName) {
        change(to: planet)
    }
    
    func change(to planet: PlanetName) {
        do {
            player = try AVAudioPlayer(contentsOf: planet.url, fileTypeHint: AVFileType.mp3.rawValue)
            print("AVFileType.mp3.rawValue")
            // player: currentTime, getDuration 등
        } catch {
            print("MusicManager Error:", error.localizedDescription)
        }
    }
}
