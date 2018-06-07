# See README.md in this dir for prerequisite setup.

PROTOC=protoc \
		--proto_path='./'

all: signal_service_proto provisioning_protos fingerprint_protos websocket_protos

signal_service_proto: OWSSignalServiceProtos.proto
	$(PROTOC) --swift_out=../src/Messages/ \
		OWSSignalServiceProtos.proto

provisioning_protos: OWSProvisioningProtos.proto
	$(PROTOC) --swift_out=../src/Devices/ \
		OWSProvisioningProtos.proto

fingerprint_protos: OWSFingerprintProtos.proto
	$(PROTOC) --swift_out=../src/Security/ \
		OWSFingerprintProtos.proto

websocket_protos: WebSocketResources.proto
	$(PROTOC) --swift_out=../src/Network/WebSockets/ \
		WebSocketResources.proto
