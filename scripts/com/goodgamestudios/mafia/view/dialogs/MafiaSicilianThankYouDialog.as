package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaSicilianThankYouDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaSicilianThankYouDialog";
       
      
      public function MafiaSicilianThankYouDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.dialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_close");
      }
      
      override protected function applyProperties() : void
      {
         var _loc1_:MovieClip = null;
         super.applyProperties();
         this.dialog.txt_progress.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_2",[Constants_SpecialEvents.SICILIAN_DUNGEONENEMIES]);
         this.dialog.dungeonProgressBar.scaleX = 1;
         this.dialog.txt_copy.text = MafiaModel.languageData.getTextById("event_sicilianbeast_copy_18");
         this.dialog.txt_reward.text = MafiaModel.languageData.getTextById("event_capovito_reward");
         MovieClipHelper.clearMovieClip(this.dialog.mc_itemHolder);
         _loc1_ = MafiaItemData.getInstance().generateItemIcon(MafiaModel.specialEvent.sicilianEvent.item);
         this.dialog.mc_itemHolder.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc1_.properties,TooltipDispPosition.None);
         _loc1_.scaleX = _loc1_.scaleY = 1.7;
         this.dialog.mc_itemHolder.addChild(_loc1_);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.dialog.btn_ok:
               hide();
         }
      }
      
      protected function get dialog() : EventDialog_6
      {
         return disp as EventDialog_6;
      }
   }
}
