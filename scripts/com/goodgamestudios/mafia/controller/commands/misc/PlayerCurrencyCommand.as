package com.goodgamestudios.mafia.controller.commands.misc
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.misc.playercurrency.PBMiscPlayerCurrencyRequest;
   import com.goodgamestudios.mafia.controller.protobuf.misc.playercurrency.PBMiscPlayerCurrencyResponse;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class PlayerCurrencyCommand extends BasicProtobufCommand
   {
       
      
      public function PlayerCurrencyCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBMiscPlayerCurrencyRequest = new PBMiscPlayerCurrencyRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMiscPlayerCurrencyResponse = param1 as PBMiscPlayerCurrencyResponse;
         MafiaModel.userData.cash = _loc2_.cash;
         MafiaModel.userData.gold = _loc2_.gold;
         if(_loc2_.hasPoliceBadges)
         {
            MafiaModel.specialEvent.breakingTheLawEvent.policeBadges = _loc2_.policeBadges;
         }
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_CURRENCY));
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMiscPlayerCurrencyRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMiscPlayerCurrencyResponse;
      }
   }
}
