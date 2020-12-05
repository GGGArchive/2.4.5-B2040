package com.goodgamestudios.mafia.controller.commands.travels
{
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.travel.quittravelflight.PBTravelQuitTravelFlightRequest;
   import com.goodgamestudios.mafia.controller.protobuf.travel.quittravelflight.PBTravelQuitTravelFlightResponse;
   import com.goodgamestudios.mafia.controller.protobuf.travel.quittravelflight.response.PBTravelQuitTravelFlightResult;
   import com.goodgamestudios.mafia.helper.MafiaPrioLoader;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaSurvivalResultData;
   import com.goodgamestudios.mafia.view.panels.MafiaTravelProgressPanel;
   import com.netease.protobuf.Message;
   
   public class QuitTravelFlightCommand extends BasicProtobufCommand
   {
       
      
      public function QuitTravelFlightCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:Boolean) : void
      {
         var _loc2_:PBTravelQuitTravelFlightRequest = new PBTravelQuitTravelFlightRequest();
         _loc2_.isFastQuit = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:PBTravelQuitTravelFlightResponse = param1 as PBTravelQuitTravelFlightResponse;
         switch(_loc2_.result)
         {
            case PBTravelQuitTravelFlightResult.OK:
               MafiaModel.userData.duelData.survivalData = new MafiaSurvivalResultData();
               layoutManager.hidePanel(MafiaTravelProgressPanel.NAME);
               _loc3_ = MafiaModel.userData.progressData.actionID;
               if(_loc3_ < City.Sicily.index)
               {
                  MafiaPrioLoader.instance.startBackgroundLoading(_loc3_);
               }
               return true;
            case PBTravelQuitTravelFlightResult.NOT_ENOUGH_GOLD:
               break;
            case PBTravelQuitTravelFlightResult.NOT_FREE:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBTravelQuitTravelFlightRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBTravelQuitTravelFlightResponse;
      }
   }
}
