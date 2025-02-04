//
//  DeviceLocationManager.swift
//
//  Copyright (c) 2020 Daniele Margutti (hello@danielemargutti.com).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import CoreLocation

internal class BeaconBroadcaster: NSObject {
    
    // MARK: - Internal Properties
    
    /// Shared instance.
    internal static let shared = BeaconBroadcaster()
    
    /// Receive callback about the advetisting.
    internal var onStatusDidChange: ((Error?) -> Void)?
    
    /// Monitored identifier.
    internal var beacon: BroadcastedBeacon?
    
    // MARK: - Private Properties
    

    // MARK: - Internal Functions
    
    /// Start broadcasting.
    internal func startBroadcastingAs(_ beacon: BroadcastedBeacon, onStatusDidChange: ((Error?) -> Void)? = nil) {
        self.beacon = beacon
        self.onStatusDidChange = onStatusDidChange
    }
    
}

// MARK: - BroadcastedBeacon

public struct BroadcastedBeacon {
    
    /// Monitored UUID.
    public let uuid: String
    
    /// Monitored identifier.
    public let identifier: String
    
    /// Monitored regions.
    public let region: CLBeaconRegion?
    
    /// Initialzie a new beacon to broadcast.
    public init?(UUID uuidIdentifier: String,
                majorID: CLBeaconMajorValue, minorID: CLBeaconMinorValue,
                identifier: String) {
        
        guard let uuidInstance = UUID(uuidString: uuidIdentifier) else {
            return nil
        }
        
        self.uuid = uuidIdentifier
        self.identifier = identifier
        
        // create the region that will be used to send
        self.region = CLBeaconRegion(
            proximityUUID: uuidInstance,
            major: majorID,
            minor: minorID,
            identifier: identifier
        )
    }
    
}
