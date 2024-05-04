//
//  TinyWeatherWidgetLiveActivity.swift
//  TinyWeatherWidget
//
//  Created by Nursultan Yelemessov on 09/03/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TinyWeatherWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TinyWeatherWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TinyWeatherWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TinyWeatherWidgetAttributes {
    fileprivate static var preview: TinyWeatherWidgetAttributes {
        TinyWeatherWidgetAttributes(name: "World")
    }
}

extension TinyWeatherWidgetAttributes.ContentState {
    fileprivate static var smiley: TinyWeatherWidgetAttributes.ContentState {
        TinyWeatherWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TinyWeatherWidgetAttributes.ContentState {
         TinyWeatherWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TinyWeatherWidgetAttributes.preview) {
   TinyWeatherWidgetLiveActivity()
} contentStates: {
    TinyWeatherWidgetAttributes.ContentState.smiley
    TinyWeatherWidgetAttributes.ContentState.starEyes
}
