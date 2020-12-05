package com.goodgamestudios.mafia.view.dialogs.calendarEvent
{
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.specialEvents.MafiaCalendarEvent;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaCalendarEventUnlockEnemyDialogProperties;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaCalendarEventUnlockEnemyDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaEddyFrostUnlockDialog";
       
      
      public function MafiaCalendarEventUnlockEnemyDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_ENDED,this.onEventEnded);
         this.standardDialog.btn_friends.visible = false;
         this.standardDialog.btn_unlock.label = MafiaModel.languageData.getTextById("event_eddyfrost_copy_13");
         this.standardDialog.btn_unlock.goldInfoVisible = true;
         this.standardDialog.btn_unlock.goldInfoTimeText = MafiaCalendarEvent.UNLOCK_DAY_GOLD_COST.toString();
         this.standardDialog.btn_unlock.enableButton = true;
         this.standardDialog.txt_copy.text = MafiaModel.languageData.getTextById("event_eddyfrost_copy_12");
         this.standardDialog.btn_no.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
         this.standardDialog.txt_title.text = MafiaModel.languageData.getTextById("event_eddyfrost_copy_9");
         updateAllTextFields();
      }
      
      override public function hide() : void
      {
         super.hide();
         controller.removeEventListener(MafiaSpecialEventsEvent.CALENDAR_EVENT_ENDED,this.onEventEnded);
      }
      
      protected function onEventEnded(param1:Event) : void
      {
         this.hide();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_unlock:
               if(!this.standardDialog.btn_unlock.enabled)
               {
                  return;
               }
               if(this.standardDialogProperties.functionYes != null)
               {
                  this.standardDialogProperties.functionYes();
               }
               this.standardDialog.btn_unlock.enableButton = false;
               this.hide();
               break;
            case this.standardDialog.btn_no:
               this.hide();
         }
      }
      
      protected function get standardDialogProperties() : MafiaCalendarEventUnlockEnemyDialogProperties
      {
         return properties as MafiaCalendarEventUnlockEnemyDialogProperties;
      }
      
      protected function get standardDialog() : MafiaUnlockGangwar
      {
         return disp as MafiaUnlockGangwar;
      }
   }
}
