class OscToSupercollider {
  
  /** /////////////////
    *** PARAMETERS
    **/ /////////////////
  OscP5 osc; // The Postman
  OscMessage msg; // The Message
  String msgName;
  NetAddress supercollider; // The Receiver
  
  /** /////////////////
  *** CONSTRUCTOR
  **/ /////////////////
  OscToSupercollider(String msgName, OscP5 osc, NetAddress supercollider){
    this.msgName = msgName;
    this.osc = osc;
    this.supercollider = supercollider;  
  }
  
  /** /////////////////
  *** SEND MESSAGE
  **/ /////////////////
  void sendToSupercollider(float val){
    msg = new OscMessage(msgName);
    msg.add(val);
    osc.send(msg, supercollider);
  }
}
