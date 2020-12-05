package com.goodgamestudios.mafia.controller.commands.police
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.PBFightPoliceEncounterRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.policeencounter.PBFightPoliceEncounterResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class PoliceEncounterCommand extends BasicProtobufCommand
   {
       
      
      public function PoliceEncounterCommand()
      {
         super();
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightPoliceEncounterResponse = param1 as PBFightPoliceEncounterResponse;
         MafiaModel.userData.policeData.parsePoliceEncounterData(_loc2_);
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightPoliceEncounterRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightPoliceEncounterResponse;
      }
   }
}
