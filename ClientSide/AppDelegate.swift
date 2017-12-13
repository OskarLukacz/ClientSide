//
//  AppDelegate.swift
//  ClientSide
//
//  Created by Oskar Lukacz on 11/28/17.
//  Copyright © 2017 Oskar Lukacz. All rights reserved.
//

import UIKit
import PubNub

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNObjectEventListener {

    var window: UIWindow?
    
    var client: PubNub!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let configuration = PNConfiguration(publishKey: "pub-c-9c5bdb04-569f-4750-b87b-d9ff4cb0611e", subscribeKey: "sub-c-f48c7bba-b810-11e7-8af2-9e87ea144307")
        configuration.stripMobilePayload = false
        self.client = PubNub.clientWithConfiguration(configuration)
        self.client.addListener(self)
        self.client.subscribeToChannels(["Swift"], withPresence: true)
        
        self.client.publish("getIP", toChannel: "Swift", withCompletion: nil)
        
        return true
    }
    
    func setUUID()
    {
        let configuration = self.client.currentConfiguration()
        configuration.uuid = user.serverSideUUID
        self.client.copyWithConfiguration(configuration, completion: { (updatedClient) in
            
            // Store reference on new client with updated configuration.
            self.client = updatedClient
        })
        
        print("Client UUID is set to: " + self.client.uuid())
    }

    // Handle new message from one of channels on which client has been subscribed.
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        
        // Handle new message stored in message.data.message
        if message.data.channel != message.data.subscription {
            
            // Message has been received on channel group stored in message.data.subscription.
        }
        else {
            
            // Message has been received on channel stored in message.data.channel.
        }
        
        print("Received message: \(String(describing: message.data.message!)) on channel \(message.data.channel) " +
            "at \(message.data.timetoken)")
        
        if String(describing:message.data.message!).hasPrefix("ServerIP=")
        {
            let response = String(describing:message.data.message!)
            
            var index = response.index(of: "=");index = response.index(index!, offsetBy: 1)
            serverIP = String(describing: response[index!...])
            print("Server IP is: \(serverIP)")
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

