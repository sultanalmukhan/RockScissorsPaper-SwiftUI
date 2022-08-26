//
//  GameView.swift
//  RockPaperScissors
//
//  Created by Султан Альмухан on 25.08.2022.
//

import SwiftUI

enum GameMode {
    case singlePlayer
    case multiPlayer
}

enum Weapon {
    case rock
    case paper
    case scissors
}

enum Result: String {
    case tie = "Tiw"
    case lose = "Lose"
    case win = "Win"
}

enum GameStage: Int {
    case firstPlayerChoosing = 0
    case firstPlayerPicked = 1
    case passMove = 2
    case secondPlayerChoosing = 3
    case secondPlayerPicked = 4
    case result = 5
}

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var mode: GameMode

    @State var gameStage: GameStage = .firstPlayerChoosing

    @State var pick: Weapon? = nil

    @State var firstPlayerChoice: Weapon?
    @State var secondPlayerChoice: Weapon?

    @State var showSecondPlayerChoosing: Bool = false

    var score = [0, 0]

    var result: Result {
        return .tie
    }

    var body: some View {
        VStack(spacing: 0) {
            headerTitle
                .padding(.top, 32)
            resultLabel
                .padding(.top, 12)
            WeaponItems(pick: $pick)
                .padding(.top, 74)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Round #1")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }

    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Image(systemName: "chevron.left")
            .foregroundColor(Color(red: 103/255, green: 80/255, blue: 164/255))
            .font(.system(size: 20))
            .aspectRatio(contentMode: .fit)
    }
    }

    var headerTitle: some View {
        VStack {
            switch gameStage {
            case .firstPlayerChoosing:
                HeaderTitle(title: "Take your pick")
            case .firstPlayerPicked:
                HeaderTitle(title: "Your pick")
            case .passMove:
                HeaderTitle(title: "Your opponent is thinking")
            case .secondPlayerChoosing:
                EmptyView()
            case .secondPlayerPicked:
                HeaderTitle(title: "Your opponent’s pick")
            case .result:
                HeaderTitle(title: result.rawValue, result: result)
            }
        }
    }

    var resultLabel: some View {
        VStack {
            switch gameStage {
            case .firstPlayerChoosing, .firstPlayerPicked, .result:
                Text("Score \(score[0]):\(score[1])")
                    .foregroundColor(Color(red: 103/255, green: 80/255, blue: 164/255))
            default:
                EmptyView()
            }
        }
    }

    var weaponIems: some View {
        VStack(spacing: 24) {
            WeaponItem(weapon: .rock)
            WeaponItem(weapon: .paper)
            WeaponItem(weapon: .scissors)
        }
    }

    var footherButton: some View {
        VStack {
            switch gameStage {
            case .firstPlayerPicked:
                FooterButton(title: "I change my mind")
            case .result:
                FooterButton(title: "Another round")
            default:
                EmptyView()
            }
        }
    }
}

struct HeaderTitle: View {
    var title: String
    var result: Result? = nil
    var colors: [Color] {
        switch result {
        case .tie:
            return [Color(red: 1, green: 204/255, blue: 0/255), Color(red: 255/255, green: 92/255, blue: 0)]
        case .lose:
            return [Color(red: 255/255, green: 105/255, blue: 97/255), Color(red: 253/255, green: 77/255, blue: 77/255)]
        case .win:
            return [Color(red: 181/255, green: 238/255, blue: 155/255), Color(red: 36/255, green: 174/255, blue: 67/255)]
        case .none:
            return [.black, .black]
        }
    }
    var body: some View {
        Text(title)
            .font(.system(size: 54, weight: .bold))
            .multilineTextAlignment(.center)
            .foregroundStyle(
                LinearGradient(
                    colors: colors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

struct WeaponItem: View {
    var weapon: Weapon

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 48)
                .fill(Color(red: 243/255, green: 242/255, blue: 248/255))
                .frame(height: 128)

            switch weapon {
            case .rock:
                Text("🗿")
                    .font(.system(size: 80))
            case .paper:
                Text("📃")
                    .font(.system(size: 80))
            case .scissors:
                Text("✂️")
                    .font(.system(size: 80))
            }
        }
        .padding(.horizontal, 24)
    }
}

struct WeaponItems: View {
    @Binding var pick: Weapon?

    var body: some View {
        VStack(spacing: 24) {
            if let pick = pick {
                Spacer()
                WeaponItem(weapon: pick)
                Spacer()
            } else {
                Button {
                    pick = .rock
                } label: {
                    WeaponItem(weapon: .rock)
                }
                Button {
                    pick = .paper
                } label: {
                    WeaponItem(weapon: .paper)
                }
                Button {
                    pick = .scissors
                } label: {
                    WeaponItem(weapon: .scissors)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(mode: .singlePlayer)
    }
}
