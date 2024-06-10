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
    @State var result_Text = "何をだそうか？"
    @State var isModal = false
    @State var total_score:Int = 0
    
    func geme_Over_check() {
        if total_score <= -10 {
            result_Text = "Game Over"
            soundPlayer.gameOverPlay()
            total_score = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                result_Text = "何を出そうか？"
                            }
        }
    }
    //じゃんけんの勝敗判定
    func janken_hantei() {
        
        switch select_janken {
        case "✊":
            if (te == "✊") {
                result_Text = "あいこ！！"
            } else if (te == "✌️") {
                result_Text = "勝った！！"
                total_score += 10
                geme_Over_check()
                soundPlayer.win_MusicPlay()
                
            } else if (te == "🖐️") {
                result_Text = "負けた！！"
                total_score -= 10
                geme_Over_check()
                soundPlayer.lose_MusicPlay()
                
            }
            
        case "✌️":
            if (te == "✊") {
                result_Text = "負けた！！"
                total_score -= 10
                geme_Over_check()
                soundPlayer.lose_MusicPlay()
                
            } else if (te == "✌️") {
                result_Text = "あいこ！！"
            } else if (te == "🖐️") {
                result_Text = "勝った！！"
                total_score += 10
                geme_Over_check()
                soundPlayer.win_MusicPlay()
                
            }
        case "🖐️":
            if (te == "✊") {
                result_Text = "勝った！！"
                total_score += 10
                soundPlayer.win_MusicPlay()
                geme_Over_check()
            } else if (te == "✌️") {
                result_Text = "負けた！！"
                total_score -= 10
                geme_Over_check()
                soundPlayer.lose_MusicPlay()
                result_Text = "何を出そうか？"
            } else if (te == "🖐️") {
                result_Text = "あいこ！！"
            }
        default:
            print("無効な入力です！！")
        }
        
    }
    
    
    var body: some View {
        
        
        
        
        VStack {
            
                Button("シートテスト") {
                isModal = true
            }
            .buttonStyle(.bordered)
            .sheet(isPresented: $isModal) {
                SomeView()
                    .presentationDetents([.height(600)])
                    .presentationDragIndicator(.visible)
            }
            
            
            
            Text("スコア:" + String(total_score))
                .foregroundColor(.white)
                .frame(width: 400, height: 50)
                .background(.mint)
                .font(.system(size: 50))
                .bold()
            
               
            //コンピュータの手　表示部分
            Text(te)
                .frame(width: 400, height: 150)                .background(.blue)
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .font(.system(size: 150))
            
            
            Spacer()
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
            
            .background(Color.blue)
            .font(.system(size: 80))
            .padding(.top,10 )

            Button("✌️") {
                
                te = janken.randomElement()!
                select_janken = "✌️"
                janken_hantei()
            }
            .font(.system(size: 80))
            .background(Color.blue)
            .padding(.top, 10 )
            
            Button("🖐️") {
                
                te = janken.randomElement()!
                select_janken = "🖐️"
                janken_hantei()
            }
            .font(.system(size: 80))
            .background(Color.blue)
            .padding(.top, 10 )
        }
        
        
        .padding()
    }
}

struct SomeView: View {
    var body: some View {
        //List(0...12, id:\.self) {item in
        Image("GO6p_yubAAAlTXq")
            .resizable()
            .frame(width: 410, height: 600) // リサイズのサイズを指定
        
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
