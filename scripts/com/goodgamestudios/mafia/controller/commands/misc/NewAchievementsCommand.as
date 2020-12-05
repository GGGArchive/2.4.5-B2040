package com.goodgamestudios.mafia.controller.commands.misc
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.protobuf.misc.newachievements.PBMiscNewAchievementsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.misc.newachievements.PBMiscNewAchievementsResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class NewAchievementsCommand extends BasicProtobufCommand
   {
       
      
      public function NewAchievementsCommand()
      {
         super();
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMiscNewAchievementsResponse = param1 as PBMiscNewAchievementsResponse;
         if(_loc2_.achievements)
         {
            MafiaModel.userData.newAchievements.parseNewAchievements(_loc2_);
            return true;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMiscNewAchievementsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMiscNewAchievementsResponse;
      }
   }
}
