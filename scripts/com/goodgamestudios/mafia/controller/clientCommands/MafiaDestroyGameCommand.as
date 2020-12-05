package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.clientCommands.BasicDestroyGameCommand;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.mafia.controller.MafiaTipController;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaBuddyList;
   import com.goodgamestudios.mafia.model.components.MafiaGoldConstantsData;
   import com.goodgamestudios.mafia.model.components.MafiaOtherUserData;
   import com.goodgamestudios.mafia.model.components.MafiaOwnUserData;
   import com.goodgamestudios.mafia.model.components.MafiaSharedObject;
   import com.goodgamestudios.mafia.model.components.MafiaSocialData;
   import com.goodgamestudios.mafia.model.components.MafiaSpecialEventData;
   import com.goodgamestudios.mafia.model.components.MafiaTipData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaDataHolder;
   
   public class MafiaDestroyGameCommand extends BasicDestroyGameCommand
   {
       
      
      public function MafiaDestroyGameCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         super.execute();
         MafiaTipController.getInstance().endTips();
         MafiaModel.userData = new MafiaOwnUserData();
         MafiaModel.otherUserData = new MafiaOtherUserData();
         MafiaModel.localData = new MafiaSharedObject();
         MafiaModel.localData.saveInstanceId(BasicModel.instanceProxy.selectedInstanceVO.instanceId);
         MafiaModel.socialData = new MafiaSocialData(BasicController.getInstance());
         MafiaModel.buddyList = new MafiaBuddyList();
         MafiaModel.tipData = new MafiaTipData();
         MafiaModel.specialEvent = new MafiaSpecialEventData();
         MafiaModel.goldConstants = new MafiaGoldConstantsData();
         MafiaDataHolder.instance.destroy();
      }
      
      override protected function get layoutManager() : BasicLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
   }
}
