//
//  ConsumerTrackerWidget.swift
//  ConsumerTrackerWidget
//
//  Created by Shahril S M B (FCES) on 19/02/2026.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),
                    drinkCount: 0,
                    calorieCount: 0,
                    configuration: ConfigurationAppIntent() )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(),
                    drinkCount:0,
                    calorieCount: 0,
                    configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let model = DataModel()
        let entry = SimpleEntry(
            date: Date(),
            drinkCount: model.consumerDetails.drinkCount,
            calorieCount: model.consumerDetails.calorieCount,
            configuration: configuration

        )

        return Timeline(entries: [entry], policy: .atEnd)
    }

    func recommendations() -> [AppIntentRecommendation<ConfigurationAppIntent>] {
        // Create an array with all the preconfigured widgets to show.
        [AppIntentRecommendation(intent: ConfigurationAppIntent(), description: "Example Widget")]
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let drinkCount:Int
    let calorieCount:Int
    let configuration: ConfigurationAppIntent
}

struct ConsumerTrackerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            HStack {
                Text("Time:")
                Text(entry.date, style: .time)
            }
        
            Text("Favorite Emoji:")
            Text(entry.configuration.favoriteEmoji)
        }
    }
}

struct ConsumerTrackerWidget: Widget {
    let kind: String = "ConsumerTrackerWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ConsumerTrackerWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .accessoryRectangular) {
    ConsumerTrackerWidget()
} timeline: {
    SimpleEntry(date: .now, drinkCount: 0, calorieCount: 0, configuration: .smiley)
    SimpleEntry(date: .now, drinkCount: 0, calorieCount: 0, configuration: .starEyes)
}    
