//
//  MusicPlayManager.swift
//  HolstThePlanets
//
//  Created by 윤범태 on 2023/06/08.
//

import AVFoundation

class MusicPlayManager {
    private(set) var player: AVAudioPlayer?
    private(set) var currentPlanet: PlanetName
    
    init(to planet: PlanetName) {
        self.currentPlanet = planet
        change(to: planet)
    }
    
    func change(to planet: PlanetName) {
        do {
            player = try AVAudioPlayer(contentsOf: planet.url, fileTypeHint: AVFileType.mp3.rawValue)
            self.currentPlanet = planet
            // player: currentTime, getDuration 등
        } catch {
            print("MusicManager Error:", error.localizedDescription)
        }
    }
    
    var musicTitle: String {
        currentPlanet.playerTitle
    }
    
    var isPlaying: Bool {
        player?.isPlaying ?? false
    }
}
