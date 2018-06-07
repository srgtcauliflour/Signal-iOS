//
//  Copyright (c) 2018 Open Whisper Systems. All rights reserved.
//

import Foundation

@objc
public class SSKEnvelope: NSObject {

    enum EnvelopeError: Error {
        case invalidProtobuf(description: String)
    }

    @objc
    public enum SSKEnvelopeType: Int {
        case unknown = 0
        case ciphertext = 1
        case keyExchange = 2
        case prekeyBundle = 3
        case receipt = 5
    }

    @objc
    public let source: String

    @objc
    public let type: SSKEnvelopeType

    @objc
    public let timestamp: UInt64

    @objc
    public let sourceDevice: UInt32

    @objc
    public let hasContent: Bool

    @objc
    public let hasLegacyMessage: Bool

    @objc
    public let relay: String?

    @objc
    public let content: Data?

    @objc
    public init(data: Data) throws {
        let proto: Signalservice_Envelope = try Signalservice_Envelope(serializedData: data)

        guard proto.hasSource else {
            throw EnvelopeError.invalidProtobuf(description: "missing required field: source")
        }
        self.source = proto.source

        guard proto.hasType else {
            throw EnvelopeError.invalidProtobuf(description: "missing required field: type")
        }
        self.type = {
            switch proto.type {
            case .unknown:
                return .unknown
            case .ciphertext:
                return .ciphertext
            case .keyExchange:
                return .keyExchange
            case .prekeyBundle:
                return .prekeyBundle
            case .receipt:
                return .receipt
            }
        }()

        guard proto.hasTimestamp else {
            throw EnvelopeError.invalidProtobuf(description: "missing required field: timestamp")
        }
        self.timestamp = proto.timestamp

        guard proto.hasSourceDevice else {
            throw EnvelopeError.invalidProtobuf(description: "missing required field: sourceDevice")
        }
        self.sourceDevice = proto.sourceDevice

        // TODO parse datamessage here, remove these flags?
        self.hasLegacyMessage = proto.hasLegacyMessage
        self.hasContent = proto.hasContent

        if proto.hasContent {
            self.content = proto.content
        } else {
            self.content = nil
        }

        if proto.relay.count > 0 {
            self.relay = proto.relay
        } else {
            relay = nil
        }
    }
}

//@objc
//class SignalServiceDataMessage: NSObject {
//    init(data: Data) throws {
//        let proto = try Signalservice_DataMessage(serializedData: data)
//        // TODO extract fields we need
//    }
//}
