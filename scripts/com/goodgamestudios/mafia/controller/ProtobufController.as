package com.goodgamestudios.mafia.controller
{
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.net.Base64;
   import com.netease.protobuf.Message;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class ProtobufController
   {
      
      protected static var protobufController:ProtobufController;
       
      
      public var commandDict:Dictionary;
      
      public function ProtobufController(param1:SingletonEnforcer#34)
      {
         super();
         this.commandDict = new Dictionary();
      }
      
      public static function getInstance() : ProtobufController
      {
         if(protobufController == null)
         {
            protobufController = new ProtobufController(new SingletonEnforcer#34());
         }
         return protobufController;
      }
      
      public function handleResponse(param1:String, param2:String) : void
      {
         var _loc4_:Class = null;
         var _loc5_:ByteArray = null;
         var _loc6_:Message = null;
         var _loc3_:BasicProtobufCommand = this.commandDict[param1];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.getResponseClass();
            if(_loc4_ != null)
            {
               _loc5_ = Base64.decodeToByteArray(param2);
               _loc6_ = new _loc4_();
               _loc6_.mergeFrom(_loc5_);
               trace("[PROTO RECEIVED]: " + this.getMessageName(_loc4_) + " - " + _loc6_.toString());
               _loc3_.executeCommand(_loc6_);
            }
            else
            {
               trace("[PROTO RECEIVED]: RESPONSE CLASS UNKNOWN!!! \'" + param1 + "\'");
            }
         }
         else
         {
            trace("[PROTO RECEIVED]: COMMAND UNKNOWN!!! \'" + param1 + "\'");
         }
      }
      
      public function handleTestResponse(param1:String, param2:Message) : void
      {
         var _loc4_:Class = null;
         var _loc3_:BasicProtobufCommand = this.commandDict[param1];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.getResponseClass();
            if(_loc4_ != null)
            {
               _loc3_.executeCommand(param2);
            }
         }
      }
      
      public function sendRequest(param1:Message) : void
      {
         var _loc4_:BasicProtobufCommand = null;
         var _loc5_:* = null;
         var _loc6_:ByteArray = null;
         var _loc7_:String = null;
         var _loc2_:Class = getDefinitionByName(getQualifiedClassName(param1)) as Class;
         var _loc3_:String = "";
         for(_loc5_ in this.commandDict)
         {
            _loc4_ = this.commandDict[_loc5_] as BasicProtobufCommand;
            if(_loc4_.getRequestClass() == _loc2_)
            {
               _loc3_ = _loc5_;
               break;
            }
         }
         if(_loc3_ != "")
         {
            _loc6_ = new ByteArray();
            param1.writeTo(_loc6_);
            _loc7_ = Base64.encodeByteArray(_loc6_);
            trace("[PROTO SENDING]: " + this.getMessageName(_loc2_) + " - " + param1.toString());
            BasicModel.smartfoxClient.sendMessage(String(_loc3_),[_loc7_]);
         }
         else
         {
            trace("trying to send unknown protobuf message");
         }
      }
      
      private function getMessageName(param1:Class) : String
      {
         var _loc2_:RegExp = /::(\w+)/g;
         var _loc3_:Object = _loc2_.exec(getQualifiedClassName(param1));
         var _loc4_:String = _loc3_[1];
         return _loc4_;
      }
   }
}

class SingletonEnforcer#34
{
    
   
   function SingletonEnforcer#34()
   {
      super();
   }
}
