//
//  ContentView.swift
//  Janken Game3
//
//  Created by ISHII TOSHIHIKO on 2024/06/09.
//

import SwiftUI
import AVKit

struct ContentView: View {
    let janken = ["✊","✌️","🖐️"]
    //音のクラスのインスタンス作成
    let soundPlayer = SoundPlayer()
    
    @State var te:String = "-"
    @State var select_janken:String = ""
    @State var result_Text:String = "何を出そうか？"
    @State var isModal:Bool = false
    @State var total_score:Int = 0
    @State var modifier:Bool = true
    @State var bounus_point:Int = 0
    
    
    
    
    func geme_Over_check() {
        
        if total_score <= -1 {
            result_Text = "Game Over"
            soundPlayer.gameOverPlay()
            modifier = false
            total_score = total_score
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                total_score = 0
                te = "-"
                result_Text = "何を出そうか？"
                modifier = true
                
            }
        }
    }
    
    func bounus_Point_Check() {
        
        switch bounus_point {
        case 1:
            print(bounus_point)
            total_score = total_score
        case 2:
            total_score = total_score + 4
        case 3:
            total_score = total_score + 8
        case 4:
            total_score = total_score + 16
        case 5...:
            total_score = total_score + 32
        default:
            break
            
        }
    }
    
    
    //じゃんけんの勝敗判定
        func janken_hantei() {
            
            switch select_janken {
            case "✊":
                
                if (te == "✊") {
                    
                    result_Text = "あいこ！！"
                    geme_Over_check()
                   
                } else if (te == "✌️") {
                    
                    result_Text = "勝った！！"
                    total_score += 10
                    bounus_point += 1
                    print(bounus_point)
                    bounus_Point_Check()
                    geme_Over_check()
                    
                    soundPlayer.win_MusicPlay()
                    
                } else if (te == "🖐️") {
                    
                    result_Text = "負けた！！"
                    total_score -= 10
                    bounus_point = 0
                    geme_Over_check()
                    soundPlayer.lose_MusicPlay()
                    
                }
                
            case "✌️":
                if (te == "✊") {
                    result_Text = "負けた！！"
                    total_score -= 10
                    bounus_point = 0
                    geme_Over_check()
                    soundPlayer.lose_MusicPlay()
                    
                    
                } else if (te == "✌️") {
                    result_Text = "あいこ！！"
                    geme_Over_check()
                    
                } else if (te == "🖐️") {
                    result_Text = "勝った！！"
                    total_score += 10
                    bounus_point += 1
                    print(bounus_point)
                    geme_Over_check()
                    soundPlayer.win_MusicPlay()
                    
                }
            case "🖐️":
                if (te == "✊") {
                    result_Text = "勝った！！"
                    total_score += 10
                    bounus_point += 1
                    print(bounus_point)
                    soundPlayer.win_MusicPlay()
                    geme_Over_check()
                    
                } else if (te == "✌️") {
                    result_Text = "負けた！！"
                    total_score -= 10
                    bounus_point = 0
                    geme_Over_check()
                    soundPlayer.lose_MusicPlay()
                    
                    
                } else if (te == "🖐️") {
                    result_Text = "あいこ！！"
                    geme_Over_check()
                }
            default:
                print("無効な入力です！！")
            }
            
        }
    
    
    
    var body: some View {
        
        
        
        
        VStack {
            
            Button("ルール説明") {
                isModal = true
            }
            .buttonStyle(.bordered)
            .sheet(isPresented: $isModal) {
                SomeView()
                    .presentationDetents([.height(600)])
                    .presentationDragIndicator(.visible)
            }
            
            Text("スコア")
                .foregroundColor(.white)
                .frame(width: 400, height: 30)
                .background(.mint)
                .font(.system(size: 30))
                .bold()
            
            Text(String(total_score))
                .foregroundColor(.white)
                .frame(width: 400, height: 45)
                .background(.mint)
                .font(.system(size: 50))
                .bold()
            
            
            //コンピュータの手　表示部分
            Text(te)
                .frame(width: 400, height: 150)                .background(.blue)
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .font(.system(size: 150))
            
                .padding()
            Spacer()
            HStack {
                
                Button("絶対に勝てる\nスキル"){
                   print(te)
                }
                .background(.blue)
                .foregroundColor(.white)
                .bold()
                
                
                Button("ポイント10倍\nスキル"){
                    
                }
                .background(.blue)
                .foregroundColor(.white)
                .bold()
                .padding()
                
                Button("ポイント10倍\nスキル"){
                    
                }
                .background(.blue)
                .foregroundColor(.white)
                .bold()
                
                
            }
            Text(result_Text)
                .frame(width: 400, height: 100)
                .background(.blue)
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .font(.system(size: 60))
                .padding(.top, 60 )
            
            
        }
        
        HStack {
            
            Button("✊") {
                
                te = janken.randomElement()!
                select_janken = "✊"
                janken_hantei()
            }
            .disabled(!modifier)
            .opacity(modifier ? 1.0 : 0.5)
            .background(Color.blue)
            .font(.system(size: 100))
            .padding(.top,10 )
            .buttonStyle(.bordered)
            

            Button("✌️") {
                
                te = janken.randomElement()!
                select_janken = "✌️"
                janken_hantei()
            }
            .disabled(!modifier)
            .opacity(modifier ? 1.0 : 0.5)
            .font(.system(size: 100))
            .background(Color.blue)
            .padding(.top, 10 )
            .buttonStyle(.bordered)
            
            Button("🖐️") {
                
                te = janken.randomElement()!
                select_janken = "🖐️"
                janken_hantei()
            }
            .disabled(!modifier)
            .opacity(modifier ? 1.0 : 0.5)
            .font(.system(size: 100))
            .background(Color.blue)
            .padding(.top, 10 )
            .buttonStyle(.bordered)
        }
        
        
        .padding()
    }
}

struct SomeView: View {
    var body: some View {
        Text("普通のじゃんけんゲームです。\n \n ")
            .frame(width: 380)
            .bold()
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}

#Preview {
    ContentView()
}
