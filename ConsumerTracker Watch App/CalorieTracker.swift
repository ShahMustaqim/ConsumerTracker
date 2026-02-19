//
//  CalorieTracker.swift
//  ConsumerTracker Watch App
//
//  Created by Shahril S M B (FCES) on 16/02/2026.
//

import SwiftUI

struct CalorieTracker: View {
    @ObservedObject var model: DataModel
    
    var body: some View {
        VStack {
            Image(systemName: "fork.knife")
                .font(.system(size:25))
            
            Text("\(model.consumerDetails.calorieCount) kcal consumed")
                .font(.title3)
            HStack {
                Button("-"){
                    model.consumerDetails.calorieCount -= 50
                }
                .controlSize(.mini)
                .padding()
                
                Button("+"){
                    model.consumerDetails.calorieCount += 50
                }
                .controlSize(.mini)
                .padding()
            }
            Button("Track"){
                model.save()
            }
            
        }
        .padding()
    }
}

#Preview {
    CalorieTracker(model:DataModel())
}
