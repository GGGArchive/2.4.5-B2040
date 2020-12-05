package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.family.changebulletinboard.PBFamilyChangeBulletinBoardRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.changebulletinboard.PBFamilyChangeBulletinBoardResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.changebulletinboard.response.PBFamilyChangeBulletinBoardResult;
   import com.netease.protobuf.Message;
   
   public class FamilyChangeBulletinBoardCommand extends BasicProtobufCommand
   {
       
      
      public function FamilyChangeBulletinBoardCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:String) : void
      {
         var _loc2_:PBFamilyChangeBulletinBoardRequest = new PBFamilyChangeBulletinBoardRequest();
         _loc2_.content = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyChangeBulletinBoardResponse = param1 as PBFamilyChangeBulletinBoardResponse;
         switch(_loc2_.result)
         {
            case PBFamilyChangeBulletinBoardResult.OK:
               return true;
            case PBFamilyChangeBulletinBoardResult.NOT_AUTHORIZED:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyChangeBulletinBoardRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyChangeBulletinBoardResponse;
      }
   }
}
