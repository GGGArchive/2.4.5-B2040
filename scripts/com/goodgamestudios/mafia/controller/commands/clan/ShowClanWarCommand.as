package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.PBFightShowFamilyWarRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.PBFightShowFamilyWarResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.request.PBFightShowFamilyWarFamilyWarType;
   import com.goodgamestudios.mafia.controller.protobuf.fight.showfamilywar.response.PBFightShowFamilyWarResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.netease.protobuf.Message;
   
   public class ShowClanWarCommand extends BasicProtobufCommand
   {
       
      
      public function ShowClanWarCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:int, param3:Number) : void
      {
         var _loc4_:PBFightShowFamilyWarRequest = new PBFightShowFamilyWarRequest();
         switch(param1)
         {
            case 1:
               _loc4_.familyWarType = PBFightShowFamilyWarFamilyWarType.ATTACK;
               break;
            case 2:
               _loc4_.familyWarType = PBFightShowFamilyWarFamilyWarType.DEFEND;
               break;
            default:
               trace("invalid clanWarType");
         }
         _loc4_.familyId = param2;
         _loc4_.fightTime = param3;
         ProtobufController.getInstance().sendRequest(_loc4_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightShowFamilyWarResponse = param1 as PBFightShowFamilyWarResponse;
         switch(_loc2_.result)
         {
            case PBFightShowFamilyWarResult.OK:
               MafiaModel.userData.userClan.parseClanWar(_loc2_.familyWarResult);
               return true;
            case PBFightShowFamilyWarResult.FAMILY_WAR_NOT_FOUND:
            case PBFightShowFamilyWarResult.NOT_A_FAMILY_MEMBER:
            case PBFightShowFamilyWarResult.INVALID_FAMILY_WAR:
            case PBFightShowFamilyWarResult.LEVEL_TOO_LOW:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightShowFamilyWarRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightShowFamilyWarResponse;
      }
   }
}
