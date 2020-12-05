package com.goodgamestudios.mafia.controller.commands.misc
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.PBMiscPlayerProfileRequest;
   import com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.PBMiscPlayerProfileResponse;
   import com.goodgamestudios.mafia.controller.protobuf.misc.playerprofile.response.PBMiscPlayerProfileResult;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class PlayerProfileCommand extends BasicProtobufCommand
   {
       
      
      public function PlayerProfileCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:Boolean, param3:String = null) : void
      {
         var _loc4_:PBMiscPlayerProfileRequest = new PBMiscPlayerProfileRequest();
         if(param3)
         {
            _loc4_.playerName = param3;
         }
         else
         {
            _loc4_.playerId = param1;
         }
         _loc4_.shortInfo = param2;
         ProtobufController.getInstance().sendRequest(_loc4_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMiscPlayerProfileResponse = param1 as PBMiscPlayerProfileResponse;
         switch(_loc2_.result)
         {
            case PBMiscPlayerProfileResult.OK:
               if(_loc2_.playerId == MafiaModel.userData.playerID)
               {
                  if(layoutManager.currentState == Constants_LayoutStates.STATE_PLAYERRANKING)
                  {
                     MafiaModel.otherUserData.profileData.playerID = _loc2_.playerId;
                     MafiaModel.otherUserData.parseProfileDataPB(_loc2_.profile);
                  }
                  else
                  {
                     MafiaModel.userData.parseProfileDataPB(_loc2_.profile);
                  }
                  return true;
               }
               MafiaModel.otherUserData.profileData.playerID = _loc2_.playerId;
               MafiaModel.otherUserData.parseProfileDataPB(_loc2_.profile);
               if(_loc2_.playerId == MafiaModel.userData.preCombatData.opponentId)
               {
                  MafiaModel.userData.preCombatData.opponentData = MafiaModel.otherUserData.profileData;
                  BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA));
               }
               return true;
            case PBMiscPlayerProfileResult.INVALID_NAME:
               BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.INVALID_NAME,[_loc2_.playerName]));
               break;
            case PBMiscPlayerProfileResult.PLAYER_UNKNOWN:
               if(_loc2_.hasPlayerName)
               {
                  BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA));
               }
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMiscPlayerProfileRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMiscPlayerProfileResponse;
      }
   }
}
