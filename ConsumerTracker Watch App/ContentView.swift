//
//  ContentView.swift
//  ConsumerTracker Watch App
//
//  Created by Shahril S M B (FCES) on 16/02/2026.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: DataModel
    @State var selectedPage: Int = 0
    var hasExceededTarget: Bool {
        model.consumerDetails.drinkCount >= model.consumerDetails.drinkTarget
    }
    var body: some View {
        TabView(selection:$selectedPage) {
            VStack {
                Image(systemName: "drop.fill")
                    .font(.system(size:25))
                    .foregroundStyle(.blue)
                Text("\(model.consumerDetails.drinkCount) mL drank today")
                    .font(.title3)
                HStack {
                    Button("-") {
                        model.consumerDetails.drinkCount -= 50
                        model.save()
                    }
                    .controlSize(.mini)
                    .padding()
                    Button("+") {
                        model.consumerDetails.drinkCount += 50
                        model.save()
                    }
                    .controlSize(.mini)
                    .padding()
                }
                ProgressView(value:(Float(model.consumerDetails.drinkCount) /
                                    Float(model.consumerDetails.drinkTarget))).tint(hasExceededTarget ? .green:.blue)
            }
            VStack {
                CalorieTracker(model:model)
            }
            VStack {
                WaterTracker(model:model)
            }
        }
        //.tabViewStyle(.verticalPage)
    }
}

#Preview {
    ContentView(model:DataModel())
}
