package com.goodgamestudios.mafia.controller.commands.specialevent
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.specialcalendar.PBSpecialeventSpecialCalendarRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.specialcalendar.PBSpecialeventSpecialCalendarResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class SpecialCalendarCommand extends BasicProtobufCommand
   {
       
      
      public function SpecialCalendarCommand()
      {
         super();
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventSpecialCalendarResponse = param1 as PBSpecialeventSpecialCalendarResponse;
         if(MafiaModel.specialEvent.calendarEvent.isEventActive)
         {
            MafiaModel.specialEvent.calendarEvent.parseEventDetails(_loc2_);
         }
         else if(MafiaModel.specialEvent.eddyFrostEvent.isEventActive)
         {
            MafiaModel.specialEvent.eddyFrostEvent.parseEventDetails(_loc2_);
         }
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventSpecialCalendarRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventSpecialCalendarResponse;
      }
   }
}
