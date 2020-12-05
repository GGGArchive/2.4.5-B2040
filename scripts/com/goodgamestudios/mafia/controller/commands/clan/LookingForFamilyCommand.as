package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.controller.protobuf.family.lookingforfamily.PBFamilyLookingForFamilyRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.lookingforfamily.PBFamilyLookingForFamilyResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.lookingforfamily.response.PBFamilyLookingForFamilyResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class LookingForFamilyCommand extends BasicProtobufCommand
   {
       
      
      public function LookingForFamilyCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBFamilyLookingForFamilyRequest = new PBFamilyLookingForFamilyRequest();
         _loc2_.isLookingForFamily = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyLookingForFamilyResponse = param1 as PBFamilyLookingForFamilyResponse;
         switch(_loc2_.result)
         {
            case PBFamilyLookingForFamilyResult.OK:
               PlayerProfileCommand.sendCommand(MafiaModel.userData.playerID,true);
               return true;
            case PBFamilyLookingForFamilyResult.PLAYER_ALREADY_IN_FAMILY:
               break;
            case PBFamilyLookingForFamilyResult.PLAYER_IS_GUEST:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyLookingForFamilyRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyLookingForFamilyResponse;
      }
   }
}
