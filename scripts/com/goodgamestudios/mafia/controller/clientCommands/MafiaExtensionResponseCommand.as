package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicExtensionResponseCommand;
   import com.goodgamestudios.basic.controller.commands.BasicCommand;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.utils.DynamicTimer;
   import flash.events.TimerEvent;
   
   public class MafiaExtensionResponseCommand extends BasicExtensionResponseCommand
   {
      
      public static var cheatedResponseDelay:uint = 0;
       
      
      public function MafiaExtensionResponseCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc3_:BasicCommand = null;
         var _loc4_:DynamicTimer = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc2_:SmartfoxEvent = param1 as SmartfoxEvent;
         if(int(_loc2_.params[0]) == -1)
         {
            _loc5_ = _loc2_.cmdId;
            _loc6_ = _loc2_.params[1];
            if(cheatedResponseDelay <= 0)
            {
               ProtobufController.getInstance().handleResponse(_loc5_,_loc6_);
               BasicController.getInstance().serverMessageArrived(_loc5_);
            }
            else
            {
               _loc4_ = new DynamicTimer(cheatedResponseDelay,0);
               _loc4_["msgType"] = "protobuf";
               _loc4_["msgId"] = _loc5_;
               _loc4_["encodedParams"] = _loc6_;
               _loc4_.addEventListener(TimerEvent.TIMER,this.delayedExecution);
               _loc4_.start();
            }
         }
         else
         {
            _loc7_ = int(_loc2_.params[0]);
            if(DictionaryUtil.containsKey(BasicController.commandDict,_loc2_.cmdId))
            {
               _loc3_ = BasicController.commandDict[_loc2_.cmdId];
               if(cheatedResponseDelay <= 0)
               {
                  _loc3_.executeCommand(_loc7_,_loc2_.params);
                  BasicController.getInstance().serverMessageArrived(_loc2_.cmdId);
               }
               else
               {
                  _loc4_ = new DynamicTimer(cheatedResponseDelay,0);
                  _loc4_["msgType"] = "old";
                  _loc4_["command"] = _loc3_;
                  _loc4_["error"] = _loc7_;
                  _loc4_["params"] = _loc2_.params.concat();
                  _loc4_["cmdId"] = _loc2_.cmdId;
                  _loc4_.addEventListener(TimerEvent.TIMER,this.delayedExecution);
                  _loc4_.start();
               }
            }
            else
            {
               trace("COMMAND UNKNOWN: " + _loc2_.cmdId);
            }
         }
      }
      
      private function delayedExecution(param1:TimerEvent) : void
      {
         var _loc2_:DynamicTimer = param1.target as DynamicTimer;
         if(_loc2_.msgType == "protobuf")
         {
            ProtobufController.getInstance().handleResponse(_loc2_.msgId,_loc2_.encodedParams);
            BasicController.getInstance().serverMessageArrived(_loc2_.msgId);
            _loc2_.encodedParams = null;
         }
         else
         {
            _loc2_.command.executeCommand(_loc2_.error,_loc2_.params);
            BasicController.getInstance().serverMessageArrived(_loc2_.cmdId);
            _loc2_.command = null;
            _loc2_.params = null;
         }
         _loc2_.removeEventListener(TimerEvent.TIMER,this.delayedExecution);
      }
   }
}
