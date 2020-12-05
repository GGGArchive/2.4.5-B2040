package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaNightOfHorrorFinishedDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaNightOfHorrorFinishedDialog";
       
      
      public function MafiaNightOfHorrorFinishedDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.dialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_close");
      }
      
      override public function hide() : void
      {
         super.hide();
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
         this.dialog.txt_copy.text = MafiaModel.languageData.getTextById("event_halloween_copy_3");
         this.dialog.txt_reward.text = MafiaModel.languageData.getTextById("event_capovito_reward");
         MovieClipHelper.clearMovieClip(this.dialog.mc_itemHolder);
         var _loc1_:MovieClip = MafiaItemData.getInstance().generateItemIcon(MafiaModel.userData.duelData.wantedData.reward.item);
         _loc1_.scaleX = _loc1_.scaleY = 2;
         this.dialog.mc_itemHolder.addChild(_loc1_);
         this.dialog.mc_itemHolder.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(_loc1_.properties,TooltipDispPosition.None);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.dialog.btn_ok:
               this.hide();
         }
      }
      
      protected function get dialog() : EventDialog_2
      {
         return disp as EventDialog_2;
      }
   }
}
