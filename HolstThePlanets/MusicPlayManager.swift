//
//  MusicPlayManager.swift
//  HolstThePlanets
//
//  Created by 윤범태 on 2023/06/08.
//

import AVFoundation
import MediaPlayer

struct MediaMetadata {
    let title: String
    let artist: String
    let albumTitle: String
    let duration: TimeInterval
    // let albumArtImage: UIImage?
    let mediaFileURL: URL
}

class MusicPlayManager {
    private(set) var player: AVAudioPlayer?
    private(set) var currentPlanet: PlanetName
    
    init(to planet: PlanetName) {
        self.currentPlanet = planet
        change(to: planet)
    }
    
    // 미디어 커맨드센터
    func addMediaToCommandCenter(_ metadata: MediaMetadata) {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.addTarget { [unowned self] event in
            guard let player = player else {
                return .commandFailed
            }
            
            if player.rate == 0.0 || player.duration != 0.0 {
                player.play()
                return .success
            }
            
            return .commandFailed
        }
        
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            guard let player = player else {
                return .commandFailed
            }
            
            if player.rate == 1.0 {
                player.pause()
                return .success
            }
            
            return .commandFailed
        }
        
        updateCommandCenterInfo(metadata: metadata)
        
        // Scrubber (슬라이더) 활성화
        commandCenter.changePlaybackPositionCommand.addTarget { [weak self] event in
            guard let self = self else {
                return .commandFailed
            }
            
            if let player = self.player {
                if let event = event as? MPChangePlaybackPositionCommandEvent {
                    player.currentTime = event.positionTime
                    return .success
                }
            }
            
            return .commandFailed
        }
    }
    
    func updateCommandCenterInfo(metadata: MediaMetadata) {
        // CommandCenter Information
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = metadata.title
        nowPlayingInfo[MPMediaItemPropertyArtist] = metadata.artist
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = metadata.albumTitle
        
        // // Image
        // if let image = metadata.albumArtImage {
        //     nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
        //         return image
        //     }
        // }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player?.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player?.rate
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func updateCommandCenterInfoCurrentTime() {
        // print(#function, player?.currentTime)
        MPNowPlayingInfoCenter.default().nowPlayingInfo![MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime
    }
    
    func change(to planet: PlanetName) {
        do {
            player = try AVAudioPlayer(contentsOf: planet.url, fileTypeHint: AVFileType.mp3.rawValue)
            self.currentPlanet = planet
            // player: currentTime, getDuration 등
            
            let metadata = MediaMetadata(title: "The Planets: \(planet.playerTitle)", artist: "Chicago Symphony Orchestra", albumTitle: "The Planets", duration: player!.duration, mediaFileURL: planet.url)
            addMediaToCommandCenter(metadata)
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
