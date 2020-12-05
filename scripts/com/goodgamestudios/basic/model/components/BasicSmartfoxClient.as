package com.goodgamestudios.basic.model.components
{
   import com.adobe.utils.StringUtil;
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.commands.BasicCommandVO;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.tracking.ConnectionTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.system.Capabilities;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import it.gotoandplay.smartfoxserver.SFSEvent;
   import it.gotoandplay.smartfoxserver.SmartFoxClient;
   import it.gotoandplay.smartfoxserver.data.Room;
   import org.osflash.signals.Signal;
   
   public class BasicSmartfoxClient extends EventDispatcher
   {
      
      public static const LOBBY_ROOM_NAME:String = "Lobby";
      
      public static const S2C_ROOMLIST:String = "rlu";
      
      public static const S2C_JOIN_ROOM:String = "jro";
      
      public static const S2C_PING:String = "pin";
      
      private static const SPACE_SUBSTITUDE:String = "<RoundHouseKick>";
       
      
      protected var sfc:SmartFoxClient;
      
      private var holdConnectionTimer:Timer;
      
      private var hasAutojoined:Boolean = false;
      
      protected var _roundTripTime:Number = 0;
      
      private var _connectionTime:Number = 0;
      
      private var _userForcedDisconnect:Boolean = false;
      
      private var _ip:String;
      
      private var _port:int;
      
      public var onRoundTripResponse:Signal;
      
      public function BasicSmartfoxClient()
      {
         super();
         this.sfc = new SmartFoxClient();
         this.sfc.httpPort = this.env.blueboxPort;
         this.sfc.httpPollSpeed = this.env.blueboxPollSpeed;
         this.debugMode = this.env.isTest || this.env.isLocal;
         this.onRoundTripResponse = new Signal();
         if(!TrackingCache.getInstance().isInitialized)
         {
            TrackingCache.getInstance().init(this.env.gameId,this.env.networkId,this.env.referrer,this.env.accountId,Capabilities.language);
         }
      }
      
      public function set userForcedDisconnect(param1:Boolean) : void
      {
         this._userForcedDisconnect = param1;
      }
      
      public function get userForcedDisconnect() : Boolean
      {
         return this._userForcedDisconnect;
      }
      
      public function get connectionTime() : Number
      {
         return this._connectionTime;
      }
      
      public function get roundTripTime() : Number
      {
         return this._roundTripTime;
      }
      
      public function connect() : void
      {
         if(!this.sfc.hasEventListener(SFSEvent.onConnection))
         {
            this.sfc.addEventListener(SFSEvent.onConnection,this.onConnection);
         }
         this.sfc.connect(this._ip,this._port);
         this._connectionTime = getTimer();
         dispatchEvent(new SmartfoxEvent(SmartfoxEvent.CONNECT_START));
      }
      
      public function executeConnection(param1:String, param2:int) : void
      {
         this._ip = param1;
         this._port = param2;
         this.connect();
      }
      
      protected function onConnection(param1:SFSEvent) : void
      {
         var _loc3_:ConnectionTrackingEvent = null;
         this.sfc.removeEventListener(SFSEvent.onConnection,this.onConnection);
         var _loc2_:InstanceVO = BasicModel.instanceProxy.selectedInstanceVO;
         TrackingCache.getInstance().instanceId = _loc2_.instanceId;
         if(param1.params.success)
         {
            this._connectionTime = getTimer() - this._connectionTime;
            _loc3_ = TrackingCache.getInstance().getEvent(ConnectionTrackingEvent.EVENT_ID) as ConnectionTrackingEvent;
            _loc3_.accountId = this.env.accountId;
            _loc3_.connectionTime = this._connectionTime.toString();
            this.sfc.addEventListener(SFSEvent.onConnectionLost,this.onConnectionLost);
            this.sfc.addEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponse);
            this.sfc.addEventListener(SFSEvent.onRoundTripResponse,this.onOnRoundTripResponse);
            this.sfc.defaultZone = _loc2_.zone;
            dispatchEvent(new SmartfoxEvent(SmartfoxEvent.CONNECT_SUCCESS));
            this.sfc.login(_loc2_.zone,"",this.env.versionDateGame + this.sfc.rawProtocolSeparator + GGSCountryController.instance.currentCountry.ggsLanguageCode + this.sfc.rawProtocolSeparator + this.env.distributorId);
         }
         else
         {
            dispatchEvent(new SmartfoxEvent(SmartfoxEvent.CONNECT_FAILED));
         }
      }
      
      private function onHoldConnectionTimer(param1:TimerEvent) : void
      {
         this.sendHoldConnectionMessage();
      }
      
      public function executeRoundTrip() : void
      {
         if(!this.sfc.hasEventListener(SFSEvent.onRoundTripResponse))
         {
            this.sfc.addEventListener(SFSEvent.onRoundTripResponse,this.onOnRoundTripResponse);
         }
         this.doRoundTripBench();
      }
      
      protected function onOnRoundTripResponse(param1:SFSEvent) : void
      {
         this.sfc.removeEventListener(SFSEvent.onRoundTripResponse,this.onOnRoundTripResponse);
         this._roundTripTime = param1.params.elapsed;
         if(!this.onRoundTripResponse)
         {
            return;
         }
         this.onRoundTripResponse.dispatch(this._roundTripTime,this.isConnectedViaHTTP());
      }
      
      private function isConnectedViaHTTP() : int
      {
         if(this.sfc.getConnectionMode() == SmartFoxClient.CONNECTION_MODE_HTTP)
         {
            return 1;
         }
         return 0;
      }
      
      protected function decompressInt(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         _loc2_ = "A".charCodeAt(0);
         _loc3_ = "z".charCodeAt(0);
         var _loc4_:int = _loc3_ - _loc2_ + 1;
         var _loc5_:int = 0;
         if(param1 && param1.length > 0)
         {
            _loc6_ = param1.length - 1;
            while(_loc6_ >= 0)
            {
               if(param1.charCodeAt(_loc6_) < _loc2_ || param1.charCodeAt(_loc6_) > _loc3_)
               {
                  return -1;
               }
               _loc5_ = _loc5_ * _loc4_ + param1.charCodeAt(_loc6_) - _loc2_;
               _loc6_--;
            }
         }
         return _loc5_;
      }
      
      private function setRoomList(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 1;
         var _loc4_:int = 2;
         var _loc5_:int = 3;
         var _loc6_:Array = this.sfc.getAllRooms();
         var _loc7_:int = param1[1];
         var _loc8_:int = this.decompressInt(param1[2]);
         var _loc9_:int = this.decompressInt(param1[3]);
         var _loc10_:int = this.decompressInt(param1[4]);
         var _loc11_:String = param1[5];
         _loc6_[_loc7_] = new Room(_loc7_,_loc11_,_loc9_,0,(_loc10_ >> _loc3_ & 1) == true,(_loc10_ >> _loc4_ & 1) == true,(_loc10_ >> _loc2_ & 1) == true,(_loc10_ >> _loc5_ & 1) == true,_loc8_,0);
         var _loc12_:Object = {};
         _loc12_.roomList = _loc6_;
         this.sfc.dispatchEvent(new SFSEvent(SFSEvent.onRoomListUpdate,_loc12_));
      }
      
      private function onExtensionResponse(param1:SFSEvent) : void
      {
         var _loc2_:Array = null;
         var _loc4_:String = null;
         _loc2_ = param1.params.dataObj;
         var _loc3_:String = _loc2_.shift();
         switch(_loc3_)
         {
            case S2C_ROOMLIST:
               this.setRoomList(_loc2_);
               this.sfc.addEventListener(SFSEvent.onJoinRoom,this.onJoinRoom);
               if(!this.hasAutojoined)
               {
                  this.hasAutojoined = true;
                  this.sfc.autoJoin();
               }
               return;
            case S2C_JOIN_ROOM:
               this.onJoinRoom(new SFSEvent("onJoinRoom",{"room":this.sfc.getRoom(parseInt(_loc2_.shift()))}));
               return;
            default:
               _loc4_ = _loc2_.shift();
               dispatchEvent(new SmartfoxEvent(SmartfoxEvent.EXTENSION_RESPONSE,_loc3_,_loc2_));
               return;
         }
      }
      
      public function logout() : void
      {
         trace("BasicSmartfoxClient, do logout");
         if(this.holdConnectionTimer)
         {
            this.holdConnectionTimer.removeEventListener(TimerEvent.TIMER,this.onHoldConnectionTimer);
            this.holdConnectionTimer.stop();
            this.holdConnectionTimer = null;
         }
         if(this.sfc.isConnected)
         {
            this._userForcedDisconnect = true;
            this.sfc.disconnect();
         }
         else
         {
            this.onConnectionLost(null);
         }
      }
      
      protected function onJoinRoom(param1:SFSEvent) : void
      {
         this.sfc.removeEventListener(SFSEvent.onJoinRoom,this.onJoinRoom);
         var _loc2_:Room = param1.params["room"] as Room;
         this.sfc.activeRoomId = _loc2_.getId();
         if(_loc2_.getName() == LOBBY_ROOM_NAME)
         {
            this.doRoundTripBench();
            this.holdConnectionTimer = new Timer(60000);
            this.holdConnectionTimer.addEventListener(TimerEvent.TIMER,this.onHoldConnectionTimer);
            this.holdConnectionTimer.start();
         }
         dispatchEvent(new SmartfoxEvent(SmartfoxEvent.JOINED_ROOM,"",[(param1.params.room as Room).getName()]));
      }
      
      public function sendRawMessage(param1:String) : void
      {
         this.sfc.sendString(this.sfc.rawProtocolSeparator + this.sfc.defaultZone + this.sfc.rawProtocolSeparator + param1 + this.sfc.rawProtocolSeparator);
      }
      
      public function sendMessage(param1:String, param2:Array) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            if(StringUtil.trim(param2[_loc3_]) == "")
            {
               param2[_loc3_] = SPACE_SUBSTITUDE;
            }
            param2[_loc3_] = TextValide.getValideSmartFoxText(param2[_loc3_]);
            _loc3_++;
         }
         this.sfc.sendXtMessage(this.sfc.defaultZone,param1,param2,SmartFoxClient.XTMSG_TYPE_STR,this.sfc.activeRoomId);
      }
      
      public function sendEmptyCommandVO(param1:BasicCommandVO) : void
      {
         if(this.isConnected)
         {
            this.sendMessage(param1.getCmdId(),[]);
         }
      }
      
      public function sendCommandVO(param1:BasicCommandVO) : void
      {
         if(this.isConnected)
         {
            this.sendMessage(param1.getCmdId(),[com.adobe.serialization.json.JSON.encode(param1)]);
         }
      }
      
      protected function onConnectionLost(param1:SFSEvent) : void
      {
         this.hasAutojoined = false;
         dispatchEvent(new SmartfoxEvent(SmartfoxEvent.CONNECTION_LOST));
      }
      
      protected function doRoundTripBench() : void
      {
         if(this.sfc && this.sfc.isConnected)
         {
            this.sfc.roundTripBench();
         }
      }
      
      protected function sendHoldConnectionMessage() : void
      {
         if(this.sfc && this.sfc.activeRoomId != -1 && this.sfc.isConnected)
         {
            this.sendMessage(S2C_PING,[]);
         }
      }
      
      protected function get advancedMessageTrace() : Boolean
      {
         return true;
      }
      
      public function get debugMode() : Boolean
      {
         return this.sfc.debug;
      }
      
      public function set debugMode(param1:Boolean) : void
      {
         this.sfc.debug = param1;
      }
      
      public function get ipAddress() : String
      {
         return this.sfc.ipAddress;
      }
      
      public function get port() : int
      {
         return this.sfc.getConnectionMode() == "http"?int(this.sfc.httpPort):int(this.sfc.port);
      }
      
      public function get defaultZone() : String
      {
         return this.sfc.defaultZone;
      }
      
      public function get activeRoom() : String
      {
         var _loc1_:Room = this.sfc.getRoom(this.sfc.activeRoomId);
         return !!_loc1_?_loc1_.getName():"Not available.";
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
      
      public function get isConnected() : Boolean
      {
         return this.sfc.isConnected;
      }
   }
}
