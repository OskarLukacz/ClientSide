import Foundation
import PubNub

let appDelegate = UIApplication.shared.delegate as! AppDelegate

public func publish(payload:String)
{
    appDelegate.client.publish(payload, toChannel: "Swift", withCompletion: nil)
}
