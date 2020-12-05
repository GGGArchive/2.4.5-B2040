package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.family.showfamily.PBFamilyShowFamilyRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.showfamily.PBFamilyShowFamilyResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.showfamily.response.PBFamilyShowFamilyResult;
   import com.goodgamestudios.mafia.event.model.MafiaClanEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowClanCommand extends BasicProtobufCommand
   {
       
      
      public function ShowClanCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int = -1) : void
      {
         var _loc2_:PBFamilyShowFamilyRequest = new PBFamilyShowFamilyRequest();
         if(param1 == -1)
         {
            param1 = MafiaModel.userData.profileData.clanID;
         }
         _loc2_.familyId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyShowFamilyResponse = param1 as PBFamilyShowFamilyResponse;
         switch(_loc2_.result)
         {
            case PBFamilyShowFamilyResult.OK:
               if(_loc2_.profile.id == MafiaModel.userData.profileData.clanID)
               {
                  MafiaModel.userData.userClan.parseData(_loc2_.profile);
                  controller.dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_USERCLAN));
               }
               else
               {
                  MafiaModel.userData.otherClan.parseData(_loc2_.profile);
                  controller.dispatchEvent(new MafiaClanEvent(MafiaClanEvent.CHANGE_OTHERCLAN));
               }
               return true;
            case PBFamilyShowFamilyResult.FAMILY_NOT_FOUND:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyShowFamilyRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyShowFamilyResponse;
      }
   }
}
