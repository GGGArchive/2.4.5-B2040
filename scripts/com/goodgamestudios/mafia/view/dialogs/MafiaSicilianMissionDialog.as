package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.commands.gangwars.ShowGangWarsCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.CityEventStateCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaSicilianEvent;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaSicilianMissionDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaSicilienDialog";
       
      
      public function MafiaSicilianMissionDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         if(MafiaModel.userData.profileData.city == City.NewYork || MafiaModel.userData.profileData.city == City.Sicily)
         {
            this.dialog.btn_go.label = MafiaModel.languageData.getTextById("event_sicilianbeast_btn_toGodfather");
         }
         else
         {
            this.dialog.btn_go.label = MafiaModel.languageData.getTextById("event_sicilianbeast_btn_toGangwarfare");
         }
         this.dialog.btn_close.label = MafiaModel.languageData.getTextById("generic_btn_close");
         controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_EVENT_DATA_UPDATED,this.onData);
         controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onTimeUpdate);
         controller.addEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onEventIsOver);
         this.fill(MafiaModel.specialEvent.sicilianEvent);
         CityEventStateCommand.sendCommand();
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_EVENT_DATA_UPDATED,this.onData);
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onTimeUpdate);
         controller.removeEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onEventIsOver);
         super.removeEvents();
      }
      
      private function onData(param1:MafiaSpecialEventsEvent) : void
      {
         this.fill(param1.params[0]);
      }
      
      private function fill(param1:MafiaSicilianEvent) : void
      {
         var _loc2_:MovieClip = null;
         this.dialog.txt_progress.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_1",[param1.solvedMissions.toString()]);
         this.dialog.missionProgressBar.scaleX = param1.totalMissions * param1.solvedMissions / 100;
         MovieClipHelper.clearMovieClip(this.dialog.mc_itemHolder);
         if(param1.item && param1.item.id > 0)
         {
            _loc2_ = MafiaItemData.getInstance().generateItemPic(param1.item.type,param1.item.subtype,param1.item.id,param1.item.quality);
            _loc2_.scaleX = _loc2_.scaleY = 1.6;
            this.dialog.mc_itemHolder.addChild(_loc2_);
            this.dialog.itemToolTipHolder.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(param1.item,TooltipDispPosition.None);
         }
         this.updateTimeText();
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.dialog.txt_copy,MafiaModel.languageData.getTextById("event_sicilianbeast_copy_5"),8);
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.dialog.txt_copy2,MafiaModel.languageData.getTextById("event_sicilianbeast_copy_3"),5);
         this.dialog.txt_reward.text = MafiaModel.languageData.getTextById("event_capovito_reward");
      }
      
      private function onTimeUpdate(param1:MafiaSpecialEventsEvent) : void
      {
         this.updateTimeText();
      }
      
      private function updateTimeText() : void
      {
         this.dialog.txt_inTown.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_4") + "\n" + MafiaModel.specialEvent.sicilianEvent.runTimeString;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.dialog.btn_go:
               hide();
               if(MafiaModel.userData.profileData.city == City.NewYork || MafiaModel.userData.profileData.city == City.Sicily)
               {
                  layoutManager.state = Constants_LayoutStates.STATE_MISSION;
               }
               else
               {
                  layoutManager.state = Constants_LayoutStates.STATE_GANGWARS;
                  ShowGangWarsCommand.sendCommand();
               }
               break;
            case this.dialog.btn_close:
               hide();
         }
      }
      
      private function onEventIsOver(param1:MafiaSpecialEventsEvent) : void
      {
         hide();
      }
      
      protected function get dialog() : EventDialog_3
      {
         return disp as EventDialog_3;
      }
   }
}
