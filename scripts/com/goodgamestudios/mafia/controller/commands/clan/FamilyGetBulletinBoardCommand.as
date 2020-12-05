package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.family.getbulletinboard.PBFamilyGetBulletinBoardRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.getbulletinboard.PBFamilyGetBulletinBoardResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.getbulletinboard.response.PBFamilyGetBulletinBoardResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class FamilyGetBulletinBoardCommand extends BasicProtobufCommand
   {
       
      
      public function FamilyGetBulletinBoardCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBFamilyGetBulletinBoardRequest = new PBFamilyGetBulletinBoardRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyGetBulletinBoardResponse = param1 as PBFamilyGetBulletinBoardResponse;
         switch(_loc2_.result)
         {
            case PBFamilyGetBulletinBoardResult.OK:
               MafiaModel.userData.userClan.parsePinboardData(_loc2_.content,_loc2_.lastChangedBy,_loc2_.writeRights);
               return true;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyGetBulletinBoardRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyGetBulletinBoardResponse;
      }
   }
}
