//
//  WaterTracker.swift
//  ConsumerTracker Watch App
//
//  Created by Shahril S M B (FCES) on 18/02/2026.
//

import SwiftUI

struct WaterTracker: View {
    @ObservedObject var model: DataModel
    var body: some View {
        VStack {
            Text("Drinking Target")
            Button("+"){
                model.consumerDetails.drinkTarget += 500
                model.save()
            }
            Text(String(model.consumerDetails.drinkTarget)).font(Font.title2)
            Button("-"){
                model.consumerDetails.drinkTarget -= 500
                model.save()
            }
        }
    }
}

#Preview {
    WaterTracker(model:DataModel())
}
