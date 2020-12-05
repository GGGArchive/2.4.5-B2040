package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_Mission;
   import com.goodgamestudios.mafia.controller.commands.specialevent.city.PayCityEventMissionCooldownCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.panels.properties.MafiaMissionSelectionProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaSicilianNoMissionPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaSicilianNoMissionPanel";
       
      
      public function MafiaSicilianNoMissionPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_MISSION_SELECTION;
         this.missionSelection.bg.gotoAndStop(2);
         this.missionSelection.missionGiverHolder.addChild(new Constants_Mission.getMissionGiverPicClass(4)());
      }
      
      override public function show() : void
      {
         super.show();
         this.missionSelection.txt_time.text = "";
         controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
         this.fillMission();
         this.updateTime();
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
      }
      
      private function fillMission() : void
      {
         this.missionSelection.btn_no.label = this.panelProperties.buttonLabel_no;
         this.missionSelection.txt_title.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_8");
         this.missionSelection.txt_copy.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_6");
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.missionSelection.txt_copy2,MafiaModel.languageData.getTextById("event_sicilianbeast_copy_11",[MafiaModel.specialEvent.sicilianEvent.solvedMissions,MafiaModel.specialEvent.sicilianEvent.totalMissions]));
         this.missionSelection.btn_gold.label = MafiaModel.languageData.getTextById("generic_btn_skip");
         this.missionSelection.btn_gold.goldInfoTimeText = MafiaModel.specialEvent.sicilianEvent.goldCosts.toString();
         this.missionSelection.btn_gold.goldInfoVisible = true;
      }
      
      private function onSicilianTimer(param1:MafiaSpecialEventsEvent) : void
      {
         this.updateTime();
      }
      
      private function updateTime() : void
      {
         var _loc1_:String = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_9") + "\n" + MafiaModel.specialEvent.sicilianEvent.missionCooldownTimeString;
         TextFieldHelper.changeTextFromatSizeByTextWidth(16,this.missionSelection.txt_time,_loc1_,2);
         if(MafiaModel.specialEvent.sicilianEvent.missionCooldown <= 0)
         {
            hide();
            if(this.panelProperties.functionNo != null)
            {
               this.panelProperties.functionNo(null);
            }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.missionSelection.btn_no:
               hide();
               if(this.panelProperties.functionNo != null)
               {
                  this.panelProperties.functionNo(null);
               }
               break;
            case this.missionSelection.btn_gold:
               PayCityEventMissionCooldownCommand.sendCommand();
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
      
      protected function get missionSelection() : MafiaSicilianNoMissionSelection
      {
         return disp as MafiaSicilianNoMissionSelection;
      }
   }
}
