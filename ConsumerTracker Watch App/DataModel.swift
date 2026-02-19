//
//  DataModel.swift
//  ConsumerTracker
//
//  Created by Shahril S M B (FCES) on 16/02/2026.
//

import SwiftUI
import Combine
import WidgetKit

class DataModel: ObservableObject {
    
    @Published var consumerDetails: ConsumerDetails = ConsumerDetails()
    
    init() {
        load()
    }
    
    func save () {
        consumerDetails.lastSavedDate = Date.now
        do {
            let data = try JSONEncoder().encode(consumerDetails)
            let url = URL.documentsDirectory.appending(path:"ConsumerTracker")
            try data.write(to:url, options:[.atomic, .completeFileProtection])
            WidgetCenter.shared.reloadTimelines(ofKind: "ConsumerTracker")
        } catch {
            print ("Save Failed")
        }
    }
    
    func load () {
        do {
            let url = URL.documentsDirectory.appending(path:"ConsumerTracker")
            let data = try Data(contentsOf: url)
            var loadedDetails = try JSONDecoder().decode(ConsumerDetails.self, from:data)
            
            if Calendar.current.isDateInToday(loadedDetails.lastSavedDate){
                consumerDetails = loadedDetails
                print("Loaded today's data")
            }else {
                print ("New day, resetting counters")
                consumerDetails = ConsumerDetails()
                save()
            }
        } catch {
            print ("Cannot load data, starting fresh")
            consumerDetails = ConsumerDetails()
        }
    }
}

struct ConsumerDetails:Codable {
    var drinkCount:Int
    var drinkTarget:Int
    var calorieCount:Int
    var lastSavedDate:Date
    
    init() {
        drinkCount = 0
        drinkTarget = 3000
        calorieCount = 0
        lastSavedDate = Date()
    }
}
