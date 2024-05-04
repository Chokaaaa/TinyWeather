//
//  TinyWeatherApp.swift
//  TinyWeather
//
//  Created by Nursultan Yelemessov on 28/02/2024.
//

import SwiftUI
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle notification action here
        completionHandler()
    }
}

@main
struct TinyWeatherApp: App {
    let notificationDelegate = NotificationDelegate()
    @StateObject var locationViewModel = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationViewModel)
                .onAppear(){
                    requestNotificationAuthorization()
                    scheduleNotifications()
                    UNUserNotificationCenter.current().delegate = notificationDelegate
                }
        }
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification authorization granted.")
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests() // Remove existing notifications
        
        let content = UNMutableNotificationContent()
        content.title = "TinyWeather"
        content.body = "Check today’s forecast 🌤"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 7 // 7 am
        dateComponents.minute = 0
        
        // Schedule notification for 7 am
        let triggerMorning = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let requestMorning = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerMorning)
        
        center.add(requestMorning) { error in
            if let error = error {
                print("Error scheduling morning notification: \(error.localizedDescription)")
            }
        }
        
        dateComponents.hour = 19 // 7 pm
        
        // Schedule notification for 7 pm
        let triggerEvening = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let requestEvening = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerEvening)
        
        center.add(requestEvening) { error in
            if let error = error {
                print("Error scheduling evening notification: \(error.localizedDescription)")
            }
        }
    }
}
