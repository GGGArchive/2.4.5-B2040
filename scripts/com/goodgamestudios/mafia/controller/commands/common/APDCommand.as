package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.basic.constants.CommonGameStates;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.basic.event.BasicAssetsEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.event.model.MafiaOfferEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.helper.MafiaPrioLoader;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.MafiaTutorialData;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.panels.MafiaQuestProgressChangePanel;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class APDCommand extends MafiaCommand
   {
       
      
      public function APDCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_GET_ALLPLAYERDATA;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 != 0)
         {
            return false;
         }
         if(BasicModel.basicLoaderData.assetLoader.isFinished)
         {
            this.joinGame();
         }
         else
         {
            BasicModel.basicLoaderData.addEventListener(BasicAssetsEvent.ASSETS_COMPLETE,this.onAssetsLoaded);
            controller.addEventListener(Event.ENTER_FRAME,this.onVisualizeItemLoadProgress);
            layoutManager.state = BasicLayoutManager.STATE_LOAD_ITEMS;
         }
         return true;
      }
      
      private function onAssetsLoaded(param1:Event = null) : void
      {
         controller.removeEventListener(BasicAssetsEvent.ASSETS_COMPLETE,this.onAssetsLoaded);
         controller.removeEventListener(Event.ENTER_FRAME,this.onVisualizeItemLoadProgress);
         this.joinGame();
      }
      
      private function onVisualizeItemLoadProgress(param1:Event) : void
      {
         layoutManager.backgroundComponent.updateLoadingProgress(Math.round(BasicModel.basicLoaderData.assetLoader.loadedRatio * 100));
      }
      
      private function joinGame() : void
      {
         MafiaModel.socialData.setSocialData(MafiaModel.userData.playerID,MafiaModel.userData.profileData.name);
         MafiaItemData.getInstance().init();
         layoutManager.onEndProgressbar();
         layoutManager.backgroundComponent.stopProgressBar();
         MafiaModel.userData.appRuntime = getTimer();
         MafiaPrioLoader.instance.startAvatarPartAndFamilyPartLoading();
         if(!MafiaTutorialData.getInstance().tutorialShown)
         {
            layoutManager.onEndProgressbar();
            MafiaTutorialController.getInstance().startTutorial(new TutorialArrow());
            CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.GAME_JOINED);
            MafiaDialogHandler.getInstance().blockDialogs = true;
            layoutManager.state = Constants_LayoutStates.STATE_WELCOME;
         }
         else
         {
            MafiaTutorialController.getInstance().tutorialState = BasicTutorialController.TUT_STATE_OFF;
            layoutManager.onEndProgressbar();
            MafiaDialogHandler.getInstance().blockDialogs = false;
            layoutManager.state = Constants_LayoutStates.STATE_HOME;
            if(MafiaModel.userData.offerData.offer && MafiaModel.userData.offerData.offer.offerID != 0)
            {
               controller.dispatchEvent(new MafiaOfferEvent(MafiaOfferEvent.CHANGE_OFFER,[MafiaModel.userData.offerData.offer.offerEndTime,MafiaModel.userData.offerData.offer.offerID,MafiaModel.userData.offerData.offer.percentGold]));
            }
            controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_PING_DATA));
         }
         MafiaPrioLoader.instance.startBackgroundLoading(MafiaModel.userData.profileData.city.index);
         if(env.hasNetworkBuddies)
         {
            MafiaModel.buddyList.getSocialBuddyData();
         }
         MafiaModel.specialEvent.initializeSpecialEvents();
         layoutManager.showPanel(MafiaQuestProgressChangePanel.NAME);
         layoutManager.hidePanel(MafiaQuestProgressChangePanel.NAME);
      }
   }
}
