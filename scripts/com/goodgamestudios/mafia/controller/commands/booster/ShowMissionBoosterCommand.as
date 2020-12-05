package com.goodgamestudios.mafia.controller.commands.booster
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.showmissionbooster.PBMissionBoosterShowMissionBoosterRequest;
   import com.goodgamestudios.mafia.controller.protobuf.mission.booster.showmissionbooster.PBMissionBoosterShowMissionBoosterResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowMissionBoosterCommand extends BasicProtobufCommand
   {
       
      
      public function ShowMissionBoosterCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBMissionBoosterShowMissionBoosterRequest = new PBMissionBoosterShowMissionBoosterRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMissionBoosterShowMissionBoosterResponse = param1 as PBMissionBoosterShowMissionBoosterResponse;
         MafiaModel.userData.boosterShop.parseBoosterShopData(_loc2_.boosters);
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMissionBoosterShowMissionBoosterRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMissionBoosterShowMissionBoosterResponse;
      }
   }
}
