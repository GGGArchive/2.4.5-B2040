package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.family.changefamilymemberstatus.PBFamilyChangeFamilyMemberStatusRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.changefamilymemberstatus.PBFamilyChangeFamilyMemberStatusResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.changefamilymemberstatus.response.PBFamilyChangeFamilyMemberStatusResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ChangeFamilyMemberStatusCommand extends BasicProtobufCommand
   {
       
      
      public function ChangeFamilyMemberStatusCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:Array) : void
      {
         var _loc2_:PBFamilyChangeFamilyMemberStatusRequest = new PBFamilyChangeFamilyMemberStatusRequest();
         _loc2_.playerId = param1[0];
         _loc2_.changeType = ProtobufEnumTranslator.translateChangeTypeToProto(param1[1]);
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyChangeFamilyMemberStatusResponse = param1 as PBFamilyChangeFamilyMemberStatusResponse;
         switch(_loc2_.result)
         {
            case PBFamilyChangeFamilyMemberStatusResult.OK:
               MafiaModel.userData.userClan.updateMember();
               return true;
            case PBFamilyChangeFamilyMemberStatusResult.FAMILY_RANK_TO_LOW:
               break;
            case PBFamilyChangeFamilyMemberStatusResult.PLAYER_HAS_NO_FAMILY:
               break;
            case PBFamilyChangeFamilyMemberStatusResult.PLAYER_IS_NOT_MEMBER_OF_FAMILY:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyChangeFamilyMemberStatusRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyChangeFamilyMemberStatusResponse;
      }
   }
}
