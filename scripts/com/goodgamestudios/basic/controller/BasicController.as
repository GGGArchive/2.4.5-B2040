package com.goodgamestudios.basic.controller
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.constants.CommonGameStates;
   import com.goodgamestudios.basic.controller.commands.BasicCommandVO;
   import com.goodgamestudios.basic.controller.externalInterface.ExternalInterfaceController;
   import com.goodgamestudios.basic.controller.externalInterface.vo.JavascriptCallOnRegisterCompleteFactory;
   import com.goodgamestudios.basic.event.BasicUserEvent;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.tracking.ConnectionTrackingUtil;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.net.PolicyPingTest;
   import com.goodgamestudios.tracking.FirstInstanceTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public final class BasicController extends EventDispatcher
   {
      
      public static const VERSION:String = "$Id: BasicController.as 4047 2012-11-28 09:09:19Z dirk.koehler $";
      
      public static const NAME:String = "BasicController";
      
      public static const COMMAND_INIT_SERVERCOMMANDS:String = "COMMAND_INIT_SERVERCOMMANDS";
      
      public static const COMMAND_EXTENSION_RESPONSE:String = "COMMAND_EXTENSION_RESPONSE";
      
      public static const COMMAND_LOGIN:String = "COMMAND_LOGIN";
      
      public static const COMMAND_LOGOUT:String = "COMMAND_LOGOUT";
      
      public static const COMMAND_CHECK_MAINTENANCE:String = "COMMAND_CHECK_MAINTENANCE";
      
      public static const COMMAND_CONNECT_CLIENT:String = "COMMAND_CONNECT_CLIENT";
      
      public static const COMMAND_CONNECTION_LOST:String = "COMMAND_CONNECTION_LOST";
      
      public static const COMMAND_CONNECTION_FAILED:String = "COMMAND_CONNECTION_FAILED";
      
      public static const COMMAND_CONNECTION_TIMEOUT:String = "COMMAND_CONNECTION_TIMEOUT";
      
      public static const COMMAND_JOINED_ROOM:String = "COMMAND_JOINED_ROOM";
      
      public static const COMMAND_INITALIZE_CONTROLLER:String = "COMMAND_INITALIZE_CONTROLLER";
      
      public static const COMMAND_REGISTER_USER:String = "COMMAND_REGISTER_USER";
      
      public static const COMMAND_RECONNECT:String = "COMMAND_RECONNECT";
      
      public static const COMMAND_OPEN_FORUM:String = "COMMAND_OPEN_FORUM";
      
      public static const COMMAND_DESTROY_GAME:String = "DESTROY_GAME";
      
      public static const COMMAND_PREPARE_RECONNECT:String = "COMMAND_PREPARE_RECONNECT";
      
      public static const COMMAND_SHOW_REGISTER_DIALOG:String = "COMMAND_SHOW_REGISTER_DIALOG";
      
      public static const COMMAND_SHOW_COMA_TEASER:String = "COMMAND_SHOW_COMA_TEASER";
      
      public static const COMMAND_CONNECT_TO_INSTANCEVO:String = "COMMAND_SELECT_INSTANCEVO_COMMAND";
      
      public static const COMMAND_INIT_COUNTRIES:String = "COMMAND_INIT_COUNTRIES";
      
      public static const COMMAND_PARSE_AVAILABLE_COUNTRIES:String = "COMMAND_PARSE_AVAILABLE_COUNTRIES";
      
      public static const COMMAND_LOGIN_JSON:String = "COMMAND_LOGIN_JSON";
      
      public static const COMMAND_REGISTER_USER_JSON:String = "COMMAND_REGISTER_USER_JSON";
      
      public static const COMMAND_INVITE_FRIEND:String = "COMMAND_INVITE_FRIEND";
      
      public static const COMMAND_INVITE_FRIEND_JSON:String = "COMMAND_INVITE_FRIEND_JSON";
      
      public static const COMMAND_CHANGE_COUNTRY:String = "COMMAND_CHANGE_COUNTRY_COMMAND";
      
      public static const COMMAND_INIT_ABTEST:String = "COMMAND_INIT_ABTEST";
      
      public static const COMMAND_INIT_SERVERLIST:String = "COMMAND_INIT_SERVERLIST";
      
      public static const COMMAND_ADD_EXTRA_CURRENCY:String = "COMMAND_ADD_EXTRA_CURRENCY";
      
      public static const COMMAND_ON_CLICK_MORE_CURRENY:String = "COMMAND_ON_CLICK_MORE_CURRENY";
      
      public static const COMMAND_USERTUNNEL_STATE:String = "COMMAND_USERTUNNEL_STATE";
      
      public static const COMMAND_TRACK_LOGIN:String = "COMMAND_TRACK_LOGIN";
      
      public static const COMMAND_RELOAD_NETWORK:String = "COMMAND_RELOAD_NETWORK";
      
      public static const COMMAND_UPDATE_NETWORK:String = "COMMAND_UPDATE_NETWORK";
      
      public static const COMMAND_FACEBOOK_INITIALIZE:String = "COMMAND_FACEBOOK_INITIALIZE";
      
      public static const COMMAND_FACEBOOK_CONNECT_LOGIN:String = "COMMAND_FACEBOOK_CONNECT_LOGIN";
      
      public static const COMMAND_TEST_CDN:String = "COMMAND_TEST_CDN";
      
      public static const COMMAND_TRACK_PROFILING:String = "COMMAND_TRACK_PROFILING";
      
      public static const COMMAND_REPLACE_AVAILABLE_COUNTRIES_BY_INSTANCE_COUNTRIES:String = "COMMAND_REPLACE_AVAILABLE_COUNTRIES_BY_INSTANCE_COUNTRIES";
      
      public static const COMMAND_TRACK_GAME_LOADING_SPEED:String = "COMMAND_TRACK_GAME_LOADING_SPEED";
      
      public static const COMMAND_CHANGE_LANGUAGE:String = "COMMAND_CHANGE_LANGUAGE";
      
      public static const COMMAND_SERVER_INFO:String = "COMMAND_SERVER_INFO";
      
      public static var commandDict:Dictionary = new Dictionary();
      
      private static var basicController:BasicController;
       
      
      public var paymentHash:String;
      
      public var cryptedForumHash:String;
      
      private var _soundController:BasicSoundController;
      
      private var waitForServerMessage:Array;
      
      private var enviromentGlobalClass:Class;
      
      public function BasicController(param1:Class)
      {
         this.waitForServerMessage = [];
         super();
         this.enviromentGlobalClass = param1;
         if(basicController)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function getInstance() : BasicController
      {
         if(!basicController)
         {
            throw new Error("Controller not initialized yet!");
         }
         return basicController;
      }
      
      public static function init(param1:Class) : void
      {
         basicController = new BasicController(param1);
      }
      
      public static function get hasBeenInitialized() : Boolean
      {
         return basicController != null;
      }
      
      public final function get soundController() : BasicSoundController
      {
         return this._soundController;
      }
      
      public final function set soundController(param1:BasicSoundController) : void
      {
         this._soundController = param1;
      }
      
      public final function onRegistered(param1:BasicUserEvent) : void
      {
         BasicController.getInstance().removeEventListener(BasicUserEvent.REGISTERED,BasicController.getInstance().onRegistered);
         this.env.isRegistered = true;
         var _loc2_:FirstInstanceTrackingEvent = TrackingCache.getInstance().getEvent(FirstInstanceTrackingEvent.EVENT_ID) as FirstInstanceTrackingEvent;
         _loc2_.registered = 1;
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.REGISTERED);
         ExternalInterfaceController.instance.executeJavaScriptFunction(new JavascriptCallOnRegisterCompleteFactory());
         ConnectionTrackingUtil.instance.executeRoundTripDelayed(ConnectionTrackingUtil.SECOND_CONNECTION_EVENT_DELAY);
         new PolicyPingTest(BasicModel.instanceProxy.selectedInstanceVO.ip,843,ConnectionTrackingUtil.THIRD_CONNECTION_EVENT_DELAY);
      }
      
      private function executeConnectionTrackingEvent(param1:Number, param2:int) : void
      {
         if(!this.env.isFirstVisit)
         {
            return;
         }
         ConnectionTrackingUtil.instance.doConnectionTracking(param1,param2);
      }
      
      public function onLogOut() : void
      {
         ConnectionTrackingUtil.instance.dispose();
         if(this.soundController)
         {
            this.soundController.stopMusic();
            this.soundController.stopAllLoopedSoundEffects();
         }
      }
      
      public function refreshSocketListener() : void
      {
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.CONNECT_SUCCESS))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_SUCCESS,this.onConnectSuccess);
         }
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.CONNECT_FAILED))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_FAILED,this.onConnectFailed);
         }
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.CONNECT_TIMEOUT))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_TIMEOUT,this.onConnectTimeout);
         }
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.JOINED_ROOM))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.JOINED_ROOM,this.onJoinedRoom);
         }
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.EXTENSION_RESPONSE))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.EXTENSION_RESPONSE,this.onExtensionResponse);
         }
         if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.CONNECTION_LOST))
         {
            BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECTION_LOST,this.onConnectionLost);
         }
      }
      
      public final function connectClient(param1:String, param2:int) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.SERVER_CONNECT);
         BasicModel.smartfoxClient.onRoundTripResponse.add(this.handleSmartfoxClientOnRoundTripResponse);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_SUCCESS,this.onConnectSuccess);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_FAILED,this.onConnectFailed);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_TIMEOUT,this.onConnectTimeout);
         BasicModel.smartfoxClient.executeConnection(param1,param2);
      }
      
      private function handleSmartfoxClientOnRoundTripResponse(param1:Number, param2:int) : void
      {
         this.executeConnectionTrackingEvent(param1,param2);
      }
      
      public function sendServerMessageVOAndWait(param1:BasicCommandVO, param2:String = "") : void
      {
         this.waitForServerMessage.push(param1.getCmdId());
         BasicModel.smartfoxClient.sendCommandVO(param1);
      }
      
      public function waitForMessage(param1:String) : void
      {
         this.waitForServerMessage.push(param1);
      }
      
      private function onConnectTimeout(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(COMMAND_CONNECTION_TIMEOUT);
      }
      
      private function onConnectFailed(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(COMMAND_CONNECTION_FAILED);
      }
      
      private function onConnectSuccess(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.SERVER_CONNECT_SUCCESS);
         BasicModel.smartfoxClient.removeEventListener(SmartfoxEvent.CONNECT_SUCCESS,this.onConnectSuccess);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.JOINED_ROOM,this.onJoinedRoom);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.EXTENSION_RESPONSE,this.onExtensionResponse);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECTION_LOST,this.onConnectionLost);
      }
      
      private function onConnectionLost(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(COMMAND_CONNECTION_LOST);
      }
      
      private function onJoinedRoom(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_JOINED_ROOM,param1);
      }
      
      public final function onReconnect() : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_RECONNECT);
      }
      
      private function onExtensionResponse(param1:SmartfoxEvent) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_EXTENSION_RESPONSE,param1);
      }
      
      public final function serverMessageArrived(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(this.waitForServerMessage.indexOf(param1) >= 0)
         {
            this.layoutManager.checkWaitingAnimState(param1);
            _loc2_ = new Array();
            _loc3_ = 0;
            while(_loc3_ < this.waitForServerMessage.length)
            {
               if(this.waitForServerMessage[_loc3_] != param1)
               {
                  _loc2_.push(this.waitForServerMessage[_loc3_]);
               }
               _loc3_++;
            }
            this.waitForServerMessage = _loc2_;
         }
      }
      
      public final function saveSoundSettings() : void
      {
         BasicModel.localData.saveSoundSettings([this.soundController.isMusicMuted,1,this.soundController.isEffectsMuted,1]);
      }
      
      public final function loginJson(param1:Object) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_LOGIN_JSON,param1);
      }
      
      public final function registerJSON(param1:String, param2:String, param3:Object) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_REGISTER_USER_JSON,[param1,param2,param3]);
      }
      
      public final function onClickMoreMoney(param1:Array) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_ON_CLICK_MORE_CURRENY,param1);
      }
      
      public final function onStartRegisterDialog() : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_SHOW_REGISTER_DIALOG);
      }
      
      public final function addExtraGold() : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_ADD_EXTRA_CURRENCY,this.paymentHash);
      }
      
      public final function inviteFriend(param1:Array) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_INVITE_FRIEND,param1);
      }
      
      public final function inviteFriendJSON(param1:Array) : void
      {
         CommandController.instance.executeCommand(BasicController.COMMAND_INVITE_FRIEND_JSON,param1);
      }
      
      private function get layoutManager() : BasicLayoutManager
      {
         return BasicLayoutManager.getInstance();
      }
      
      public final function sendServerMessageAndWait(param1:String, param2:Array, param3:String) : void
      {
         this.waitForServerMessage.push(param3);
         BasicModel.smartfoxClient.sendMessage(param1,param2);
      }
      
      public final function sendCommandVOAndWait(param1:BasicCommandVO) : void
      {
         this.waitForServerMessage.push(param1.getCmdId());
         BasicModel.smartfoxClient.sendCommandVO(param1);
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new this.enviromentGlobalClass();
      }
   }
}
