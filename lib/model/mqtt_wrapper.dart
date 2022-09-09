import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}
enum MqttSubscriptionState {
  IDLE,
  SUBSCRIBED
}

class MQTTClientWrapper {

  late MqttClient client;

  MqttCurrentConnectionState currentConnectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;
  
  void _setupMqqtClient() {
    final String clientId = 'flutter_client_${DateTime.now().millisecondsSinceEpoch}'; 
    client = MqttServerClient.withPort('103.144.187.42', clientId, 1883);
    // client = MqttServerClient.withPort('test.mosquitto.org', '#', 1883);
    // client = MqttServerClient.withPort('broker.hivemq.com', '#', 1883);
    client.logging(on: false);
    client.keepAlivePeriod = 60;
    client.autoReconnect = true;
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;
  }

  Future<void> _connectClient() async {
    try {
      print('MQTTClientWrapper::Mosquitto client connecting....');
      currentConnectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect();
    } on Exception catch (e) {
      print('MQTTClientWrapper::Mosquitto client exception - $e');
      currentConnectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTTClientWrapper::Mosquitto client connected');
      currentConnectionState = MqttCurrentConnectionState.CONNECTED;
    } else {
      print('MQTTClientWrapper::Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      currentConnectionState = MqttCurrentConnectionState.DISCONNECTED;
      client.disconnect();
    }
  }

  void _onConnected() {
    print('MQTTClientWrapper::Mosquitto client connected');
    currentConnectionState = MqttCurrentConnectionState.CONNECTED;
  }

  void _onDisconnected() {
    print('MQTTClientWrapper::OnDisconnected client callback - Client disconnection');
    currentConnectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _subscribeToTopic(String topic) {
    print('MQTTClientWrapper::Subscribing to topic $topic');
    client.subscribe(topic, MqttQos.atLeastOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      
      final String message = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('MQTTClientWrapper::Message received on topic ${c[0].topic} with payload $message');
      onMessageReceived(message);
    });
  }

  void _onSubscribed(String topic) {
    print('MQTTClientWrapper::OnSubscribed client callback - Subscription to topic $topic succeeded');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
    // check if function defined
    onSubscribed();
  }

  late final Function(String) onMessageReceived;
  late final Function() onSubscribed;

  void prepareMtqqtClient(String topic) async {
    _setupMqqtClient();
    await _connectClient();
    if (currentConnectionState == MqttCurrentConnectionState.CONNECTED) {
      _subscribeToTopic(topic);
    }
  }

  final builder = MqttClientPayloadBuilder();
  void publishMessage(String topic, String message) {
    builder.addString(message);
    print('MQTTClientWrapper::Publishing message $message to topic $topic');
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    builder.clear();
  }

  void disconnect() {
    client.disconnect();
  }
}