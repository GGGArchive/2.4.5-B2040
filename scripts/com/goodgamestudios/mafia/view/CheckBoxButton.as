package com.goodgamestudios.mafia.view
{
   import flash.display.MovieClip;
   
   public class CheckBoxButton extends NewBasicUIButton
   {
       
      
      protected var check:MovieClip;
      
      public function CheckBoxButton()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         if(getChildByName("mc_check"))
         {
            this.check = getChildByName("mc_check") as MovieClip;
         }
         if(!_selected)
         {
            this.deselected();
         }
      }
      
      override public function selected() : void
      {
         if(!enabled)
         {
            return;
         }
         _selected = true;
         if(this.check)
         {
            this.check.visible = true;
         }
      }
      
      override public function deselected() : void
      {
         if(!enabled)
         {
            return;
         }
         _selected = false;
         if(this.check)
         {
            this.check.visible = false;
         }
      }
   }
}
