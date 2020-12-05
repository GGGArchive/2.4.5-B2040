package com.goodgamestudios.mafia.controller.commands.police
{
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.PBFightStartPoliceFightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.PBFightStartPoliceFightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startpolicefight.response.PBFightStartPoliceFightResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.netease.protobuf.Message;
   
   public class StartPoliceFightCommand extends BasicProtobufCommand
   {
       
      
      public function StartPoliceFightCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:Boolean) : void
      {
         var _loc2_:PBFightStartPoliceFightRequest = new PBFightStartPoliceFightRequest();
         _loc2_.wantsToFight = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightStartPoliceFightResponse = param1 as PBFightStartPoliceFightResponse;
         switch(_loc2_.result)
         {
            case PBFightStartPoliceFightResult.OK:
               if(_loc2_.hasFight)
               {
                  MafiaModel.userData.policeData.parsePoliceFightData(_loc2_);
                  MafiaFightController.getInstance().startFight(MafiaModel.userData.policeData.resultData,FightType.Police);
                  MafiaDialogHandler.getInstance().blockDialogs = true;
               }
               else
               {
                  MafiaModel.userData.policeData.clearEncounter();
               }
               return true;
            case PBFightStartPoliceFightResult.CANNOT_GET_OPPONENT:
               MafiaLayoutManager.getInstance().state = MafiaLayoutManager.getInstance().stateBeforeFight;
               return false;
            default:
               trace("SPFCommand error " + _loc2_.result);
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightStartPoliceFightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightStartPoliceFightResponse;
      }
   }
}
