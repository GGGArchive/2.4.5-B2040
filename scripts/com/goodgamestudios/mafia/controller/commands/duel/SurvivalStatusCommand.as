package com.goodgamestudios.mafia.controller.commands.duel
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.PBFightSurvivalStatusRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.PBFightSurvivalStatusResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.survivalstatus.response.PBFightSurvivalStatusResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class SurvivalStatusCommand extends BasicProtobufCommand
   {
       
      
      public function SurvivalStatusCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBFightSurvivalStatusRequest = new PBFightSurvivalStatusRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightSurvivalStatusResponse = param1 as PBFightSurvivalStatusResponse;
         switch(_loc2_.result)
         {
            case PBFightSurvivalStatusResult.OK:
               if(layoutManager.currentState == Constants_LayoutStates.STATE_DUEL)
               {
                  layoutManager.state = Constants_LayoutStates.STATE_SURVIVAL;
               }
               MafiaModel.userData.duelData.survivalData.parseSurvivalData(_loc2_);
               return true;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightSurvivalStatusRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightSurvivalStatusResponse;
      }
   }
}
