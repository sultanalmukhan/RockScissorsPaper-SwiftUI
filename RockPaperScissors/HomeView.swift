//
//  HomeView.swift
//  RockPaperScissors
//
//  Created by Султан Альмухан on 25.08.2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                background
                VStack {
                    titleLabel
                    Spacer()
                    buttons
                }
            }
        }
    }

    var background: some View {
        Image("homeBg")
            .resizable()
            .ignoresSafeArea()
    }

    var titleLabel: some View {
        Text("Welcome to the game!")
            .foregroundColor(.white)
            .font(.system(size: 54, weight: .semibold, design: .default))
            .multilineTextAlignment(.center)
            .padding(.top, 80)
    }

    var buttons: some View {
        VStack {
            NavigationLink(destination: GameView(mode: .singlePlayer)) {
                FooterButton(title: "Single player")
            }
            NavigationLink(destination: GameView(mode: .multiPlayer)) {
                FooterButton(title: "Multi player")
            }
        }
        .padding(.bottom)
    }
}

struct FooterButton: View {
    var title: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(red: 103/255, green: 80/255, blue: 164/255))
                .frame(height: 50)
            Text(title)
                .foregroundColor(.white)
        }
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
