package com.goodgamestudios.mafia.controller.commands.quest
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.protobuf.quest.finishquest.PBQuestFinishQuestRequest;
   import com.goodgamestudios.mafia.controller.protobuf.quest.finishquest.PBQuestFinishQuestResponse;
   import com.goodgamestudios.mafia.controller.protobuf.quest.finishquest.response.PBQuestFinishQuestResult;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.quest.MafiaQuestData;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaCompleteQuestDialogProperties;
   import com.goodgamestudios.mafia.view.dialogs.quest.MafiaCompleteQuestDialog;
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   import com.netease.protobuf.Message;
   
   public class FinishQuestCommand extends BasicProtobufCommand
   {
       
      
      public function FinishQuestCommand()
      {
         super();
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBQuestFinishQuestResponse = null;
         var _loc3_:MafiaQuestData = null;
         var _loc4_:int = 0;
         var _loc5_:QuestVO = null;
         _loc2_ = param1 as PBQuestFinishQuestResponse;
         switch(_loc2_.result)
         {
            case PBQuestFinishQuestResult.OK:
               _loc3_ = MafiaModel.userData.questData;
               _loc4_ = _loc2_.questId;
               _loc5_ = _loc3_.getQuestById(_loc4_);
               MafiaDialogHandler.getInstance().registerDialogs(MafiaCompleteQuestDialog.NAME,new MafiaCompleteQuestDialogProperties(_loc5_),true,BasicDialogHandler.PRIORITY_HIGH);
               BasicController.getInstance().dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.QUEST_COMPLETED,[_loc5_]));
               GetActiveQuestsCommand.sendCommand();
               return true;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBQuestFinishQuestRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBQuestFinishQuestResponse;
      }
   }
}
