//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Jordan Luna on 8/26/20.
//  Copyright © 2020 Jordan Luna. All rights reserved.
//

import SwiftUI

//view

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration:0.75)){
                        viewModel.chooseCard(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            
            Button(action: { withAnimation(.easeInOut){
                    viewModel.resetGame()
                }
            }, label: {
                Text("New Game")
            })
            .padding()
            .foregroundColor(Color.orange)
        }

    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader{ geometry in
            body(for: geometry.size)
        }
    }
    

    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)){
            animatedBonusRemaining = 0
        }
        
    }
    
    
    @ViewBuilder
    private func body(for size: CGSize)-> some View{
        if card.isFaceUp || !card.isMatched {
            ZStack{
                Group{
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockWise: true)
                            .onAppear{
                                startBonusTimeAnimation()
                            }
                    }
                    else{
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockWise: true)
                    }
                }
                .padding(5).opacity(0.40)
                Text(card.content)
                .aspectRatio(aspectRatio, contentMode: .fit)
                    .font(Font.system(size: fontSize(for: size)))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                    
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
        }
    }
    
    
    private func fontSize(for size: CGSize)->CGFloat{
        min(size.width,size.height) * fontScaleFactor
    }
    
//    MARK: -drawing constants
    

    private let fontScaleFactor:CGFloat = 0.7
    private let aspectRatio:CGFloat = 2/3
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return  EmojiMemoryGameView(viewModel:EmojiMemoryGame())
    }
}



//@ObservedObject: we will watch for notifications from @published varibles in that class
//and when changes are reported we will reload views dependent on them
 
