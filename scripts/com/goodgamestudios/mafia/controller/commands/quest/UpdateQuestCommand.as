package com.goodgamestudios.mafia.controller.commands.quest
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.protobuf.quest.updatequest.PBQuestUpdateQuestResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class UpdateQuestCommand extends BasicProtobufCommand
   {
       
      
      public function UpdateQuestCommand()
      {
         super();
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBQuestUpdateQuestResponse = param1 as PBQuestUpdateQuestResponse;
         MafiaModel.userData.questData.parseQuestUpdate(_loc2_);
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return null;
      }
      
      override public function getResponseClass() : Class
      {
         return PBQuestUpdateQuestResponse;
      }
   }
}
