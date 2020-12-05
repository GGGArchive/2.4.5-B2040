package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_Mission;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.controller.commands.gangwars.ShowGangWarsCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.panels.properties.MafiaMissionSelectionProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaSicilianGoToGangwarPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaSicilianGoToGangwarPanel";
       
      
      public function MafiaSicilianGoToGangwarPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_MISSION_SELECTION;
         this.missionSelection.bg.gotoAndStop(1);
         this.missionSelection.missionGiverHolder.addChild(new Constants_Mission.getMissionGiverPicClass(4)());
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
         this.missionSelection.btn_ok.label = this.panelProperties.buttonLabel_yes;
         this.missionSelection.btn_no.label = this.panelProperties.buttonLabel_no;
         this.missionSelection.txt_title.text = MafiaModel.languageData.getTextById("event_sicilianbeast_title");
         if(MafiaModel.specialEvent.sicilianEvent.gangwarEnemiesKilled == Constants_SpecialEvents.SICILIAN_DUNGEONENEMIES)
         {
            this.missionSelection.txt_copy.text = "";
            this.missionSelection.txt_copy2.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_18");
         }
         else
         {
            this.missionSelection.txt_copy.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_15");
            this.missionSelection.txt_copy2.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_16");
         }
         this.missionSelection.txt_progress.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_11",[MafiaModel.specialEvent.sicilianEvent.gangwarEnemiesKilled,Constants_SpecialEvents.SICILIAN_DUNGEONENEMIES]);
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
      }
      
      private function onSicilianTimer(param1:MafiaSpecialEventsEvent) : void
      {
         if(MafiaModel.specialEvent.sicilianEvent.runTimeInSeconds > 0)
         {
            TextFieldHelper.changeTextFromatSizeByTextWidth(16,this.missionSelection.txt_time,MafiaModel.languageData.getTextById("event_sicilianbeast_copy_12") + "\n" + String(param1.params[0]),2);
         }
         else
         {
            hide();
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.missionSelection.btn_ok:
               hide();
               layoutManager.state = Constants_LayoutStates.STATE_GANGWARS;
               ShowGangWarsCommand.sendCommand();
               if(this.panelProperties.functionNo != null)
               {
                  this.panelProperties.functionNo(null);
               }
               break;
            case this.missionSelection.btn_no:
               hide();
               if(this.panelProperties.functionNo != null)
               {
                  this.panelProperties.functionNo(null);
               }
         }
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            if(env.hasNetworkBuddies)
            {
               disp.scaleY = disp.scaleX = disp.stage.stageWidth / Constants_Basic.GAME_WIDTH;
            }
            else
            {
               disp.scaleX = disp.scaleY = disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT;
            }
            disp.x = Constants_Basic.GAME_WIDTH * 0.5 * disp.scaleX + layoutManager.gameNullPoint;
            disp.y = PANEL_YPOS * disp.scaleY;
         }
      }
      
      protected function get panelProperties() : MafiaMissionSelectionProperties
      {
         return properties as MafiaMissionSelectionProperties;
      }
      
      protected function get missionSelection() : MafiaSicilianGoToGangwar
      {
         return disp as MafiaSicilianGoToGangwar;
      }
   }
}
