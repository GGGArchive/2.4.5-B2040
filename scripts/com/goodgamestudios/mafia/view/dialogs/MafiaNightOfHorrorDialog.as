package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaNightOfHorrorEvent;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MafiaNightOfHorrorDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaNightOfHorrorDialog";
       
      
      public function MafiaNightOfHorrorDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.dialog.btn_go.label = MafiaModel.languageData.getTextById("event_capovito_btn_toDuelScreen");
         this.dialog.btn_close.label = MafiaModel.languageData.getTextById("generic_btn_close");
         controller.addEventListener(MafiaSpecialEventsEvent.NIGHTOFHORROR_DATA_UPDATED,this.onData);
         controller.addEventListener(MafiaSpecialEventsEvent.NIGHTOFHORROR_TIME_UPDATE,this.onTimeUpdate);
         controller.addEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onEventEnded);
         if(MafiaModel.specialEvent.nightOfHorrorEvent.item)
         {
            this.fillNightOfHorror(MafiaModel.specialEvent.nightOfHorrorEvent);
         }
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaSpecialEventsEvent.NIGHTOFHORROR_DATA_UPDATED,this.onData);
         controller.removeEventListener(MafiaSpecialEventsEvent.NIGHTOFHORROR_TIME_UPDATE,this.onTimeUpdate);
         controller.removeEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onEventEnded);
         super.removeEvents();
      }
      
      private function onData(param1:MafiaSpecialEventsEvent) : void
      {
         this.fillNightOfHorror(param1.params[0]);
      }
      
      private function fillNightOfHorror(param1:MafiaNightOfHorrorEvent) : void
      {
         var _loc2_:ItemVO = param1.item;
         var _loc3_:MovieClip = MafiaItemData.getInstance().generateItemIcon(_loc2_);
         if(param1.item)
         {
            this.dialog.weaponHolder.addChild(_loc3_);
         }
      }
      
      private function onTimeUpdate(param1:MafiaSpecialEventsEvent) : void
      {
         this.dialog.txt_inTown.text = MafiaModel.languageData.getTextById("event_halloween_inTown") + "\n" + param1.params[0];
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
         this.dialog.txt_copy.text = MafiaModel.userData.profileData.level >= 12?MafiaModel.languageData.getTextById("event_halloween_copy_1"):MafiaModel.languageData.getTextById("event_halloween_copy_4");
         this.dialog.txt_reward.text = MafiaModel.languageData.getTextById("event_capovito_reward");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.dialog.btn_go:
               hide();
               layoutManager.state = Constants_LayoutStates.STATE_DUEL;
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_DUEL,[1]);
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_SURVIVAL_COOLDOWN,[]);
               break;
            case this.dialog.btn_close:
               hide();
         }
      }
      
      protected function onEventEnded(param1:Event) : void
      {
         hide();
      }
      
      protected function get dialog() : EventDialog_1
      {
         return disp as EventDialog_1;
      }
   }
}
