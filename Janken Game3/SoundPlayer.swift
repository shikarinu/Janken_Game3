//
//  SoundPlayer.swift
//  Janken Game3
//
//  Created by ISHII TOSHIHIKO on 2024/06/10.
//

import UIKit
import AVFoundation


class SoundPlayer: NSObject {
    //gameover の音
    let gameoverData = NSDataAsset(name: "gameover")!.data
    let win_MusicData = NSDataAsset(name: "win")!.data
    let lose_MusicData = NSDataAsset(name: "lose")!.data
    
    //gameover用プレイヤー変数
    var gameoverPlayer: AVAudioPlayer!
    var win_MusicPlayer: AVAudioPlayer!
    var lose_MusicPlayer: AVAudioPlayer!
    
    //GmameOver music
    func gameOverPlay() {
        do {
            gameoverPlayer = try AVAudioPlayer(data: gameoverData)
            
            gameoverPlayer.play()
        } catch {
            print("予期していないエラー")
        }
    }
    //WIN music
    func win_MusicPlay() {
        do {
            win_MusicPlayer = try AVAudioPlayer(data: win_MusicData)
            
            win_MusicPlayer.play()
        } catch {
            print("予期していないエラー")
        }
               
    }
    
    func lose_MusicPlay() {
        do {
            lose_MusicPlayer = try AVAudioPlayer(data: lose_MusicData)
            
            lose_MusicPlayer.play()
        } catch {
            print("予期していないエラー")
        }
               
    }
    
}


